import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/features/chat/domain/entities/chat_entity.dart';

class ChatModel extends ChatEntity {
  const ChatModel(
      {required super.senderUid,
      required super.recipientUid,
      required super.senderName,
      required super.recipientName,
      required super.recentTextMessage,
      required super.createdAt,
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
  factory ChatModel.fromChatEntity(ChatEntity entity) {
    return ChatModel(
      senderUid: entity.senderUid,
      senderName: entity.senderName,
      recipientUid: entity.recipientUid,
      recipientName: entity.recipientName,
      recentTextMessage: entity.recentTextMessage,
      createdAt: entity.createdAt,
      senderProfile: entity.senderProfile,
      recipientProfile: entity.recipientProfile,
      totalUnReadMessages: entity.totalUnReadMessages,
    );
  }
  ChatModel copyWith({
    String? senderUid,
    String? recipientUid,
    String? senderName,
    String? recipientName,
    String? recentTextMessage,
    Timestamp? createdAt,
    String? senderProfile,
    String? recipientProfile,
    int? totalUnReadMessages,
  }) {
    return ChatModel(
      senderUid: senderUid ?? this.senderUid,
      recipientUid: recipientUid ?? this.recipientUid,
      senderName: senderName ?? this.senderName,
      recipientName: recipientName ?? this.recipientName,
      recentTextMessage: recentTextMessage ?? this.recentTextMessage,
      createdAt: createdAt ?? this.createdAt,
      senderProfile: senderProfile ?? this.senderProfile,
      recipientProfile: recipientProfile ?? this.recipientProfile,
      totalUnReadMessages: totalUnReadMessages ?? this.totalUnReadMessages,
    );
  }
}
