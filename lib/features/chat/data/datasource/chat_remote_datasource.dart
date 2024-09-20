import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_media_app/core/const/fireabase_const/firebase_collection.dart';
import 'package:social_media_app/core/const/enums/message_type.dart';
import 'package:social_media_app/core/utils/errors/exception.dart';
import 'package:social_media_app/core/utils/other/get_last_message.dart';
import 'package:social_media_app/features/chat/data/model/chat_model.dart';
import 'package:social_media_app/features/chat/data/model/message_model.dart';
import 'package:social_media_app/features/chat/domain/entities/message_entity.dart';
import 'package:social_media_app/core/services/assets/asset_model.dart';

abstract interface class ChatRemoteDatasource {
  Future<void> sendMessage(ChatModel chat, List<MessageEntity> message);
  Stream<List<ChatModel>> getMyChat(String myId);
  Stream<List<MessageModel>> getSingleUserMessages(
      String sendorId, String recipientId);
  Future<void> deleteMessage(List<MessageEntity> messages);
  Future<void> seenMessageUpdate(
      String sendorId, String recieverId, String messageId);
  Future<void> blockAndUnblockChat(
      String myId, String otherUserId, bool isBlock);
  Future<void> deleteChat(String myId, String otherUserId);
}

class ChatRemoteDatasourceImpl implements ChatRemoteDatasource {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _firebaseStorage;

  ChatRemoteDatasourceImpl(
      {required FirebaseFirestore firestore,
      required FirebaseStorage firebaseStorage})
      : _firestore = firestore,
        _firebaseStorage = firebaseStorage;

  @override
  Future<void> sendMessage(ChatModel chat, List<MessageEntity> messages) async {
    final time = FieldValue.serverTimestamp();

    try {
      await _firestore.runTransaction((transaction) async {
        // Read operations
        final myChatRef = _firestore
            .collection(FirebaseCollectionConst.users)
            .doc(chat.senderUid)
            .collection(FirebaseCollectionConst.myChat)
            .doc(chat.recipientUid);

        final myChatDoc = await transaction.get(myChatRef);

        // Write operations
        await addMessagesToChat(transaction, messages, time, chat);
        await addToChat(
            transaction,
            chat.copyWith(
              recentTextMessage: getRecentTextMessage(
                  MessageModel.fromMessageEntity(messages.last)),
            ),
            time,
            myChatDoc.exists);
      });
    } catch (e) {
      log(e.toString());
      throw Exception("Error sending message");
    }
  }

  Future<void> addToChat(Transaction transaction, ChatModel chat,
      FieldValue time, bool isChatDocExists) async {
    final senderId = chat.senderUid;
    final receiverId = chat.recipientUid;
    final myChatRef = _firestore
        .collection(FirebaseCollectionConst.users)
        .doc(chat.senderUid)
        .collection(FirebaseCollectionConst.myChat)
        .doc(chat.recipientUid);

    final otherChatRef = _firestore
        .collection(FirebaseCollectionConst.users)
        .doc(chat.recipientUid)
        .collection(FirebaseCollectionConst.myChat)
        .doc(chat.senderUid);

    final myNewChat = chat.copyWith(
      senderUid: senderId,
      otherUserProfile: chat.senderProfile,
      otherUserName: chat.senderName,
      recipientUid: receiverId,
    );

    final otherNewChat = chat.copyWith(
      senderUid: receiverId,
      recipientUid: senderId,
      otherUserName: chat.recipientName,
      otherUserProfile: chat.recipientProfile,
    );

    if (!isChatDocExists) {
      transaction.set(otherChatRef, myNewChat.toJson(time: time));
      transaction.set(myChatRef, otherNewChat.toJson(time: time));
    } else {
      transaction.update(otherChatRef, myNewChat.toJson(time: time));
      transaction.update(myChatRef, otherNewChat.toJson(time: time));
    }
  }

  Future<void> addMessagesToChat(Transaction transaction,
      List<MessageEntity> messages, FieldValue time, ChatModel chat) async {
    final myMessagesRef = _firestore
        .collection(FirebaseCollectionConst.users)
        .doc(chat.senderUid)
        .collection(FirebaseCollectionConst.myChat)
        .doc(chat.recipientUid)
        .collection(FirebaseCollectionConst.messages);

    final otherMessagesRef = _firestore
        .collection(FirebaseCollectionConst.users)
        .doc(chat.recipientUid)
        .collection(FirebaseCollectionConst.myChat)
        .doc(chat.senderUid)
        .collection(FirebaseCollectionConst.messages);

    for (var messageEntity in messages) {
      var message = MessageModel.fromMessageEntity(messageEntity);

      if (message.messageType != MessageTypeConst.textMessage &&
          message.messageType != MessageTypeConst.gifMessage) {
        log(message.assetPath?.toString() ?? 'null');
        if (message.assetPath == null) {
          throw const MainException(errorMsg: "Asset path missing");
        }
        final fileUrl = await uploadMessageAssets(
            message.assetPath!, chat.senderUid, message.messageId);
        message = message.copyWith(assetLink: fileUrl);
        log(fileUrl);
      }

      MessageModel myMessage = message;
      MessageModel recieverMsg = message;
      if (message.isItReply) {
        if (message.repliedToMe != null && message.repliedToMe!) {
          myMessage = myMessage.copyWith(repliedTo: 'You');
          recieverMsg = recieverMsg.copyWith(repliedTo: message.repliedTo);
        } else {
          myMessage = myMessage.copyWith(repliedTo: message.repliedTo);
          recieverMsg = recieverMsg.copyWith(repliedTo: 'You');
        }
      }
      // Use set to create a new document for each message
      transaction.set(myMessagesRef.doc(message.messageId),
          myMessage.toDocument(time: time));
      transaction.set(otherMessagesRef.doc(message.messageId),
          recieverMsg.toDocument(time: time));
    }
  }

  String _getMessageTypeFromString(String messageType) {
    switch (messageType) {
      case 'photoMessage':
        return '📷 Photo';
      case 'videoMessage':
        return '📸 Video';
      case 'audioMessage':
        return '🎵 Audio';
      case 'gifMessage':
        return 'GIF';
      default:
        return '';
    }
  }

  @override
  Future<void> deleteChat(String myId, String otherUserId) async {
    try {
      final chatRef = _firestore
          .collection(FirebaseCollectionConst.users)
          .doc(myId)
          .collection(FirebaseCollectionConst.myChat)
          .doc(otherUserId);
      final messagesRef = chatRef.collection(FirebaseCollectionConst.messages);

      final batch = _firestore.batch();

      // Fetch all documents (messages) in the sub-collection
      final snapshot = await messagesRef.get();

      // Delete each document (message) in the sub-collection
      for (var doc in snapshot.docs) {
        batch.delete(doc.reference);
      }

      // Commit the batch deletion
      await batch.commit();
      await chatRef.update({'recentTextMessage': ''});
    } catch (e) {
      throw const MainException(); // Handle any exceptions that occur
    }
  }

  @override
  Future<void> deleteMessage(List<MessageEntity> messages) async {
    try {
      log('delete method for chat called $messages');
      for (var message in messages) {
        final myMessagesRef = _firestore
            .collection('users')
            .doc(message.senderUid)
            .collection('myChat')
            .doc(message.recipientUid)
            .collection('messages')
            .doc(message.messageId);

        final otherMessagesRef = _firestore
            .collection('users')
            .doc(message.recipientUid)
            .collection('myChat')
            .doc(message.senderUid)
            .collection('messages')
            .doc(message.messageId);

        // Check if assetLink is not null before attempting to delete
        if (message.assetLink != null) {
          try {
            final ref = FirebaseStorage.instance.refFromURL(message.assetLink!);

            // Check if the file exists by getting its metadata
            await ref.getMetadata();

            // If metadata retrieval is successful, delete the file
            await ref.delete();
          } catch (e) {
            if (e is FirebaseException && e.code == 'object-not-found') {
              log('File does not exist, no need to delete.');
            } else {
              log('Error deleting message: ${e.toString()}');
              throw const MainException(); // Re-throw your custom exception
            }
          }
        }

        // Perform the transaction
        await _firestore.runTransaction((transaction) async {
          try {
            // Delete the message from sender's chat
            transaction.delete(myMessagesRef);

            // Delete the message from receiver's chat
            transaction.delete(otherMessagesRef);
          } catch (e) {
            throw const MainException();
          }
        });

        final chatRef = _firestore
            .collection('users')
            .doc(message.senderUid)
            .collection('myChat')
            .doc(message.recipientUid);
        final otherChatRef = _firestore
            .collection('users')
            .doc(message.recipientUid)
            .collection('myChat')
            .doc(message.senderUid);

        final previousMessagesQuery = await _firestore
            .collection('users')
            .doc(message.senderUid)
            .collection('myChat')
            .doc(message.recipientUid)
            .collection('messages')
            .orderBy('createdAt', descending: true)
            .limit(1)
            .get();

        if (previousMessagesQuery.docs.isNotEmpty) {
          String lastMsg = _getMessageTypeFromString(
              previousMessagesQuery.docs.first['messageType']);

          await chatRef.update({
            'recentTextMessage': lastMsg.isEmpty
                ? previousMessagesQuery.docs.first['message']
                : lastMsg
          });

          await otherChatRef.update({
            'recentTextMessage': lastMsg.isEmpty
                ? previousMessagesQuery.docs.first['message']
                : lastMsg
          });
        } else {
          // No messages left, so set recentTextMessage to an empty string
          await chatRef.update({'recentTextMessage': ''});

          await otherChatRef.update({'recentTextMessage': ''});
        }
      }
    } catch (e) {
      log('Error deleting messages: $e');
      throw const MainException();
    }
  }

  @override
  Stream<List<ChatModel>> getMyChat(String myId) {
    final myChatRef = _firestore
        .collection(FirebaseCollectionConst.users)
        .doc(myId)
        .collection(FirebaseCollectionConst.myChat)
        .orderBy("createdAt", descending: true);

    return myChatRef.snapshots().map((querySnapshot) {
      log('stream called');
      return querySnapshot.docs.map((e) => ChatModel.fromJson(e)).toList();
    });
  }

  @override
  Stream<List<MessageModel>> getSingleUserMessages(
      String sendorId, String recipientId) {
    log('id is && $sendorId  && $recipientId');
    final messagesRef = _firestore
        .collection(FirebaseCollectionConst.users)
        .doc(sendorId)
        .collection(FirebaseCollectionConst.myChat)
        .doc(recipientId)
        .collection(FirebaseCollectionConst.messages)
        .orderBy("createdAt", descending: false);
    // final messagesRef = _firestore
    //     .collection(FirebaseCollectionConst.users)
    //     .doc(sendorId)
    //     .collection(FirebaseCollectionConst.myChat)
    //     .doc(recipientId)
    //     .collection(FirebaseCollectionConst.messages)
    //     .orderBy("createdAt", descending: false);

    return messagesRef.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => MessageModel.fromJson(e)).toList());
  }

  Future<String> uploadMessageAssets(
      SelectedByte assetPath, String path, String id) async {
    try {
      //if not status images is picked return empty list

      Reference ref = _firebaseStorage.ref().child('chatImages').child(path);

      UploadTask task = ref.child(id).putFile(assetPath.selectedFile);
      TaskSnapshot snapshot = await task;

      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<void> seenMessageUpdate(
      String sendorId, String recieverId, String messageId) async {
    try {
      final messagesRef = _firestore
          .collection(FirebaseCollectionConst.users)
          .doc(recieverId)
          .collection(FirebaseCollectionConst.myChat)
          .doc(sendorId)
          .collection('messages');

      await messagesRef.doc(messageId).update({'isSeen': true});
    } catch (e) {
      throw const MainException();
    }
  }

  @override
  Future<void> blockAndUnblockChat(
      String myId, String otherUserId, bool isBlock) async {
    try {
      final myChatRef = _firestore
          .collection(FirebaseCollectionConst.users)
          .doc(myId)
          .collection(FirebaseCollectionConst.myChat)
          .doc(otherUserId);

      final otherChatRef = _firestore
          .collection(FirebaseCollectionConst.users)
          .doc(otherUserId)
          .collection(FirebaseCollectionConst.myChat)
          .doc(myId);
      if (isBlock) {
        await myChatRef.update({'isBlockedByMe': true});
        await otherChatRef.update({'isBlockedByMe': false});
      } else {
        await myChatRef.update({'isBlockedByMe': null});
        await otherChatRef.update({'isBlockedByMe': null});
      }
    } catch (e) {
      throw const MainException();
    }
  }
}
