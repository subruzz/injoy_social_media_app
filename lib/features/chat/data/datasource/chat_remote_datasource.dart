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
  Future<void> sendMessage(ChatModel chat, MessageModel message);
  Stream<List<ChatModel>> getMyChat(String myId);
  Stream<List<MessageModel>> getSingleUserMessages(
      String sendorId, String recipientId);
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

  String combineIds(String id1, String id2) {
    List<String> ids = [id1, id2];
    ids.sort(); // Sort IDs alphabetically or numerically

    return ids.join('_'); // Combine IDs with an underscore separator
  }

  @override
  Future<void> sendMessage(ChatModel chat, MessageModel message) async {
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

    await addToChat(chat);
  }

  Future<void> addToChat(ChatModel chat) async {
    final myChatRef = _firestore
        .collection(FirebaseCollectionConst.users)
        .doc(chat.senderUid)
        .collection(FirebaseCollectionConst.myChat);

    final otherChatRef = _firestore
        .collection(FirebaseCollectionConst.users)
        .doc(chat.recipientUid)
        .collection(FirebaseCollectionConst.myChat);
    final myNewChat = chat.toJson();

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

  Future<void> sendMessagesByType(MessageModel message) async {
    // users -> uid -> myChat -> uid -> messages -> messageIds
    final combinedId = combineIds(message.senderUid!, message.recipientUid!);
    final myMessageRef = _firestore
        .collection(FirebaseCollectionConst.messages)
        .doc(combinedId)
        .collection('oneToOneMessages');

    // final otherMessageRef = _firestore
    //     .collection(FirebaseCollectionConst.users)
    //     .doc(message.recipientUid)
    //     .collection(FirebaseCollectionConst.myChat)
    //     .doc(message.senderUid)
    //     .collection(FirebaseCollectionConst.messages);
    String messageId = IdGenerator.generateUniqueId();

    final newMessage = message.toDocument();

    try {
      await myMessageRef.doc(messageId).set(newMessage);
      // await otherMessageRef.doc(messageId).set(newMessage);
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
  Stream<List<ChatModel>> getMyChat(String myId) {
    final myChatRef = _firestore
        .collection(FirebaseCollectionConst.users)
        .doc(myId)
        .collection(FirebaseCollectionConst.myChat)
        .orderBy("createdAt", descending: true);

    return myChatRef.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => ChatModel.fromJson(e)).toList());
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

  @override
  Future<void> seenMessageUpdate(MessageEntity message) async {
    throw UnimplementedError();
  }
}
