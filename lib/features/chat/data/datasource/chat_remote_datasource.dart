import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_media_app/core/const/fireabase_const/firebase_collection.dart';
import 'package:social_media_app/core/const/enums/message_type.dart';
import 'package:social_media_app/core/errors/exception.dart';
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

  Future<void> deleteChat(String myId);
}

class ChatRemoteDatasourceImpl implements ChatRemoteDatasource {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _firebaseStorage;

  ChatRemoteDatasourceImpl(
      {required FirebaseFirestore firestore,
      required FirebaseStorage firebaseStorage})
      : _firestore = firestore,
        _firebaseStorage = firebaseStorage;

  String combineIds(String id1, String id2) {
    List<String> ids = [id1, id2];
    ids.sort(); // Sort IDs alphabetically or numerically

    return ids.join('_'); // Combine IDs with an underscore separator
  }

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
              recentTextMessage: _getRecentTextMessage(
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

  String _getRecentTextMessage(MessageModel message) {
    switch (message.messageType) {
      case MessageTypeConst.photoMessage:
        return '📷 Photo';
      case MessageTypeConst.videoMessage:
        return '📸 Video';
      case MessageTypeConst.audioMessage:
        return '🎵 Audio';
      case MessageTypeConst.gifMessage:
        return 'GIF';
      default:
        return message.message ?? '';
    }
  }

  @override
  Future<void> deleteChat(String myId) async {
    try {
      final userRef = _firestore
          .collection(FirebaseCollectionConst.users)
          .doc(myId)
          .collection(FirebaseCollectionConst.myChat);
      final batch = _firestore.batch();

      // Fetch all documents in the sub-collection
      final snapshot = await userRef.get();

      // Delete each document in the sub-collection
      for (var doc in snapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    } catch (e) {
      throw const MainException();
    }
  }

  @override
  Future<void> deleteMessage(List<MessageEntity> messages) async {
    try {
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
            await FirebaseStorage.instance
                .refFromURL(message.assetLink!)
                .delete();
          } catch (e) {
            throw const MainException();
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
      }
    } catch (e) {
      print('Error deleting messages: $e');
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

      UploadTask task = ref.child(id).putFile(assetPath.selectedFile!);
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
    // try {
    //   final combinedId = combineIds(sendorId, recieverId);
    //   final messagesRef = _firestore
    //       .collection(FirebaseCollectionConst.messages)
    //       .doc(combinedId)
    //       .collection('oneToOneMessages');
    //   await messagesRef.doc(messageId).update({'isSeen': true});
    // } catch (e) {
    //   throw const MainException();
    // }
  }
}
