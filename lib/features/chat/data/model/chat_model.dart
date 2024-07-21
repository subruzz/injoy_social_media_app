import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/features/chat/domain/entities/chat_entity.dart';

class ChatModel extends ChatEntity {
  const ChatModel(
      {required super.senderUid,
      required super.recipientUid,
      required super.recipientName,
      required super.recentTextMessage,
      required super.createdAt,
      super.recipientProfile,
      super.totalUnReadMessages});

  factory ChatModel.fromJson(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;
    log('time is ${snap['createdAt']}');
    return ChatModel(
      recentTextMessage: snap['recentTextMessage'],
      recipientName: snap['recipientName'],
      totalUnReadMessages: snap['totalUnReadMessages'],
      recipientUid: snap['recipientUid'],
      senderUid: snap['senderUid'],
      recipientProfile: snap['recipientProfile'],
      createdAt: snap['createdAt'],
    );
  }

  Map<String, dynamic> toJson({required FieldValue time}) => {
        "recentTextMessage": recentTextMessage,
        "recipientName": recipientName,
        "totalUnReadMessages": totalUnReadMessages,
        "recipientUid": recipientUid,
        "senderUid": senderUid,
        "recipientProfile": recipientProfile,
        "createdAt": time,
      };
  factory ChatModel.fromChatEntity(ChatEntity entity) {
    return ChatModel(
      senderUid: entity.senderUid,
      recipientUid: entity.recipientUid,
      recipientName: entity.recipientName,
      recentTextMessage: entity.recentTextMessage,
      createdAt: entity.createdAt,
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
      recipientName: recipientName ?? this.recipientName,
      recentTextMessage: recentTextMessage ?? this.recentTextMessage,
      createdAt: createdAt ?? this.createdAt,
      recipientProfile: recipientProfile ?? this.recipientProfile,
      totalUnReadMessages: totalUnReadMessages ?? this.totalUnReadMessages,
    );
  }
}
