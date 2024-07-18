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

abstract interface class ChatRemoteDatasource {
  Future<void> sendMessage(ChatEntity chat, MessageEntity message);
  Stream<List<ChatModel>> getMyChat(ChatEntity chat);
  Stream<List<MessageModel>> getSingleUserMessages(MessageEntity message);
  Future<void> deleteMessage(MessageEntity message);
  Future<void> seenMessageUpdate(MessageEntity message);

  Future<void> deleteChat(ChatEntity chat);
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
  Future<void> sendMessage(ChatEntity chat, MessageEntity message) async {
    await sendMessagesByType(message);

    String recentTextMessage = "";

    switch (message.messageType) {
      case MessageTypeConst.photoMessage:
        recentTextMessage = '📷 Photo';
        break;
      case MessageTypeConst.videoMessage:
        recentTextMessage = '📸 Video';
        break;
      case MessageTypeConst.audioMessage:
        recentTextMessage = '🎵 Audio';
        break;
      case MessageTypeConst.gifMessage:
        recentTextMessage = 'GIF';
        break;
      default:
        recentTextMessage = message.message!;
    }

    await addToChat(ChatEntity(
      createdAt: chat.createdAt,
      senderProfile: chat.senderProfile,
      recipientProfile: chat.recipientProfile,
      recentTextMessage: recentTextMessage,
      recipientName: chat.recipientName,
      senderName: chat.senderName,
      recipientUid: chat.recipientUid,
      senderUid: chat.senderUid,
      totalUnReadMessages: chat.totalUnReadMessages,
    ));
  }

  Future<void> addToChat(ChatEntity chat) async {
    final myChatRef = _firestore
        .collection(FirebaseCollectionConst.users)
        .doc(chat.senderUid)
        .collection(FirebaseCollectionConst.myChat);

    final otherChatRef = _firestore
        .collection(FirebaseCollectionConst.users)
        .doc(chat.recipientUid)
        .collection(FirebaseCollectionConst.myChat);
    final myNewChat = ChatModel(
      createdAt: chat.createdAt,
      senderProfile: chat.senderProfile,
      recipientProfile: chat.recipientProfile,
      recentTextMessage: chat.recentTextMessage,
      recipientName: chat.recipientName,
      senderName: chat.senderName,
      recipientUid: chat.recipientUid,
      senderUid: chat.senderUid,
      totalUnReadMessages: chat.totalUnReadMessages,
    ).toJson();

    final otherNewChat = ChatModel(
            createdAt: chat.createdAt,
            senderProfile: chat.recipientProfile,
            recipientProfile: chat.senderProfile,
            recentTextMessage: chat.recentTextMessage,
            recipientName: chat.senderName,
            senderName: chat.recipientName,
            recipientUid: chat.senderUid,
            senderUid: chat.recipientUid,
            totalUnReadMessages: chat.totalUnReadMessages)
        .toJson();
    try {
      myChatRef.doc(chat.recipientUid).get().then((myChatDoc) async {
        // Create
        if (!myChatDoc.exists) {
          await myChatRef.doc(chat.recipientUid).set(myNewChat);
          await otherChatRef.doc(chat.senderUid).set(otherNewChat);
          return;
        } else {
          // Update
          await myChatRef.doc(chat.recipientUid).update(myNewChat);
          await otherChatRef.doc(chat.senderUid).update(otherNewChat);
          return;
        }
      });
    } catch (e) {
      throw const MainException();
    }
  }

  Future<void> sendMessagesByType(MessageEntity message) async {
    // users -> uid -> myChat -> uid -> messages -> messageIds

    final myMessageRef = _firestore
        .collection(FirebaseCollectionConst.users)
        .doc(message.senderUid)
        .collection(FirebaseCollectionConst.myChat)
        .doc(message.recipientUid)
        .collection(FirebaseCollectionConst.messages);

    final otherMessageRef = _firestore
        .collection(FirebaseCollectionConst.users)
        .doc(message.recipientUid)
        .collection(FirebaseCollectionConst.myChat)
        .doc(message.senderUid)
        .collection(FirebaseCollectionConst.messages);
    String messageId = IdGenerator.generateUniqueId();

    final newMessage = MessageModel(
            senderUid: message.senderUid,
            recipientUid: message.recipientUid,
            senderName: message.senderName,
            recipientName: message.recipientName,
            createdAt: message.createdAt,
            repliedTo: message.repliedTo,
            repliedMessage: message.repliedMessage,
            isSeen: message.isSeen,
            messageType: message.messageType,
            message: message.message,
            messageId: messageId,
            repliedMessageType: message.repliedMessageType)
        .toDocument();

    try {
      await myMessageRef.doc(messageId).set(newMessage);
      await otherMessageRef.doc(messageId).set(newMessage);
    } catch (e) {
      throw const MainException();
    }
  }

  @override
  Future<void> deleteChat(ChatEntity chat) async {
    try {} catch (e) {
      throw const MainException();
    }
  }

  @override
  Future<void> deleteMessage(MessageEntity message) async {
    throw UnimplementedError();
  }

  @override
  Stream<List<ChatModel>> getMyChat(ChatEntity chat) {
    final myChatRef = _firestore
        .collection(FirebaseCollectionConst.users)
        .doc(chat.senderUid)
        .collection(FirebaseCollectionConst.myChat)
        .orderBy("createdAt", descending: true);

    return myChatRef.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => ChatModel.fromJson(e)).toList());
  }

  @override
  Stream<List<MessageModel>> getSingleUserMessages(MessageEntity message) {
    final messagesRef = _firestore
        .collection(FirebaseCollectionConst.users)
        .doc(message.senderUid)
        .collection(FirebaseCollectionConst.myChat)
        .doc(message.recipientUid)
        .collection(FirebaseCollectionConst.messages)
        .orderBy("createdAt", descending: false);

    return messagesRef.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => MessageModel.fromJson(e)).toList());
  }

  @override
  Future<void> seenMessageUpdate(MessageEntity message) async {
    throw UnimplementedError();
  }
}
