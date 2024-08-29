import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/features/chat/domain/entities/chat_entity.dart';

class ChatModel extends ChatEntity {
  const ChatModel(
      {required super.senderUid,
      required super.recipientUid,
      super.recipientName,
      required super.recentTextMessage,
      required super.createdAt,
      super.recipientProfile,
      required super.lastMessageId,
      super.senderName,
      super.senderProfile,
      super.otherUserName,
      super.isBlockedByMe,
      required super.lastSenderId,
      super.otherUserProfile,
      super.totalUnReadMessages});

  factory ChatModel.fromJson(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;
    log('time is ${snap['createdAt']}');
    return ChatModel(
      isBlockedByMe: snap['isBlockedByMe'],
      lastMessageId: snap['lastMessageId'],
      lastSenderId: snap['lastSenderId'],
      recentTextMessage: snap['recentTextMessage'],
      otherUserProfile: snap['otherUserProfile'],
      totalUnReadMessages: snap['totalUnReadMessages'],
      recipientUid: snap['recipientUid'],
      senderUid: snap['senderUid'],
      otherUserName: snap['otherUserName'],
      createdAt: snap['createdAt'],
    );
  }

  Map<String, dynamic> toJson({required FieldValue time}) => {
        "recentTextMessage": recentTextMessage,
        "otherUserName": otherUserName,
        "totalUnReadMessages": totalUnReadMessages,
        "recipientUid": recipientUid,
        "senderUid": senderUid,
        "otherUserProfile": otherUserProfile,
        "createdAt": time,
        'lastMessageId': lastMessageId,
        'lastSenderId': lastSenderId
      };
  factory ChatModel.fromChatEntity(ChatEntity entity) {
    return ChatModel(
      isBlockedByMe: entity.isBlockedByMe,
      lastMessageId: entity.lastMessageId,
      senderName: entity.senderName,
      lastSenderId: entity.lastSenderId,
      senderProfile: entity.senderProfile,
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
    bool? isBlockedByMe,
    String? recipientUid,
    String? senderName,
    String? lastSenderId,
    String? recipientName,
    String? recentTextMessage,
    Timestamp? createdAt,
    String? senderProfile,
    String? otherUserProfile,
    String? lastMessageId,
    String? otherUserName,
    String? recipientProfile,
    int? totalUnReadMessages,
  }) {
    return ChatModel(
      isBlockedByMe: isBlockedByMe ?? this.isBlockedByMe,
      lastMessageId: lastMessageId ?? this.lastMessageId,
      lastSenderId: lastSenderId ?? this.lastSenderId,
      otherUserName: otherUserName ?? this.otherUserName,
      otherUserProfile: otherUserProfile ?? this.otherUserProfile,
      senderName: senderName ?? this.senderName,
      senderProfile: senderProfile ?? this.senderProfile,
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
