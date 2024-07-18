import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/features/chat/domain/entities/chat_entity.dart';

class ChatModel extends ChatEntity {
  const ChatModel(
      {super.senderUid,
      super.recipientUid,
      super.senderName,
      super.recipientName,
      super.recentTextMessage,
      super.createdAt,
      super.senderProfile,
      super.recipientProfile,
      super.totalUnReadMessages});

  factory ChatModel.fromJson(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;

    return ChatModel(
      recentTextMessage: snap['recentTextMessage'],
      recipientName: snap['recipientName'],
      totalUnReadMessages: snap['totalUnReadMessages'],
      recipientUid: snap['recipientUid'],
      senderName: snap['senderName'],
      senderUid: snap['senderUid'],
      senderProfile: snap['senderProfile'],
      recipientProfile: snap['recipientProfile'],
      createdAt: snap['createdAt'],
    );
  }

  Map<String, dynamic> toJson() => {
        "recentTextMessage": recentTextMessage,
        "recipientName": recipientName,
        "totalUnReadMessages": totalUnReadMessages,
        "recipientUid": recipientUid,
        "senderName": senderName,
        "senderUid": senderUid,
        "senderProfile": senderProfile,
        "recipientProfile": recipientProfile,
        "createdAt": createdAt,
      };
}
