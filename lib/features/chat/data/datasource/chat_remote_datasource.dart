import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:social_media_app/core/const/fireabase_const/firebase_collection.dart';
import 'package:social_media_app/core/const/message_type.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/utils/id_generator.dart';
import 'package:social_media_app/features/chat/data/model/chat_model.dart';
import 'package:social_media_app/features/chat/data/model/message_model.dart';
import 'package:social_media_app/features/chat/domain/entities/chat_entity.dart';
import 'package:social_media_app/features/chat/domain/entities/message_entity.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/utils.dart';

abstract interface class ChatRemoteDatasource {
  Future<void> sendMessage(ChatModel chat, List<MessageEntity> message);
  Stream<List<ChatModel>> getMyChat(String myId);
  Stream<List<MessageModel>> getSingleUserMessages(
      String sendorId, String recipientId);
  Future<void> deleteMessage(
      String sendorId, String recieverId, String messageId);
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
    // *firebase transaction will cause an error if we we perfom any
    //* kind of write operation before read opeation
    try {
      await _firestore.runTransaction((transaction) async {
        // Performing read operations
        final myChatRef = _firestore
            .collection(FirebaseCollectionConst.users)
            .doc(chat.senderUid)
            .collection(FirebaseCollectionConst.myChat)
            .doc(chat.recipientUid);

        final myChatDoc = await transaction.get(myChatRef);

        // Then only perform write operations
        await sendMessagesByType(transaction, messages, time, chat);

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
      throw const MainException();
    }
  }

  Future<void> addToChat(Transaction transaction, ChatModel chat,
      FieldValue time, bool isChatDocExists) async {
    final senderId = chat.senderUid;
    final receiverId = chat.recipientUid;
    final myChatRef = _firestore
        .collection(FirebaseCollectionConst.users)
        .doc(chat.senderUid)
        .collection(FirebaseCollectionConst.myChat);

    final otherChatRef = _firestore
        .collection(FirebaseCollectionConst.users)
        .doc(chat.recipientUid)
        .collection(FirebaseCollectionConst.myChat);
    log('iam ${chat.senderName}');
    final myNewChat = chat
        .copyWith(
          senderUid: senderId,
          recipientUid: receiverId,
        )
        .toJson(time: time);
    final otherNewChat = chat
        .copyWith(
            senderUid: receiverId,
            recipientUid: senderId,
            recipientName: chat.senderName,
            recipientProfile: chat.senderProfile)
        .toJson(time: time);

    // Use the provided transaction for Firestore operations
    if (!isChatDocExists) {
      transaction.set(myChatRef.doc(chat.recipientUid), myNewChat);
      transaction.set(otherChatRef.doc(chat.senderUid), otherNewChat);
    } else {
      transaction.update(myChatRef.doc(chat.recipientUid), myNewChat);
      transaction.update(otherChatRef.doc(chat.senderUid), otherNewChat);
    }
  }

  Future<void> sendMessagesByType(Transaction transaction,
      List<MessageEntity> messages, FieldValue time, ChatModel chat) async {
    final combinedId = combineIds(chat.senderUid, chat.recipientUid);

    final myMessageRef = _firestore
        .collection(FirebaseCollectionConst.messages)
        .doc(combinedId)
        .collection('oneToOneMessages');

    for (var messageEntity in messages) {
      var message = MessageModel.fromMessageEntity(messageEntity);

      if (message.messageType != MessageTypeConst.textMessage &&
          message.messageType != MessageTypeConst.gifMessage) {
        log(message.assetPath?.toString() ?? 'null');
        if (message.assetPath == null) throw const MainException();
        final fileUrl = await uploadMessageAssets(
            message.assetPath!, combinedId, message.messageId);
        message = message.copyWith(assetLink: fileUrl);
        log(fileUrl);
      }

      final newMessage = message.toDocument(time: time);

      transaction.set(myMessageRef.doc(message.messageId), newMessage);
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

      // Fetch all documents in the sub-collection
      final snapshot = await userRef.get();

      // Delete each document in the sub-collection
      for (DocumentSnapshot doc in snapshot.docs) {
        await doc.reference.delete();
      }

      print('Chat collection deleted successfully.');
    } catch (e) {
      throw const MainException();
    }
  }

  @override
  Future<void> deleteMessage(
      String sendorId, String recieverId, String messageId) async {
    log('chat called');
    try {
      final combinedId = combineIds(sendorId, recieverId);
      log(combinedId);
      log(messageId);
      final myMessageRef = _firestore
          .collection(FirebaseCollectionConst.messages)
          .doc(combinedId)
          .collection('oneToOneMessages')
          .doc(messageId);
      final m = await myMessageRef.get();
      log(m.exists.toString());
      await myMessageRef.delete();
    } catch (e) {
      log(e.toString());
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
    final combinedId = combineIds(sendorId, recipientId);
    final messagesRef = _firestore
        .collection(FirebaseCollectionConst.messages)
        .doc(combinedId)
        .collection('oneToOneMessages')
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

      UploadTask task = ref.child(id).putData(assetPath.selectedByte);
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
      final combinedId = combineIds(sendorId, recieverId);
      final messagesRef = _firestore
          .collection(FirebaseCollectionConst.messages)
          .doc(combinedId)
          .collection('oneToOneMessages');
      await messagesRef.doc(messageId).update({'isSeen': true});
    } catch (e) {
      throw const MainException();
    }
  }
}
