import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  final String senderUid;
  final String recipientUid;
  final String? senderName;
  final String? recipientName;
  final String? otherUserName;
  final String? otherUserProfile;
  final String recentTextMessage;
  final Timestamp createdAt;
  final String? senderProfile;
  final String? recipientProfile;
  final num? totalUnReadMessages;
  final bool ? isBlockedByMe;
  final String lastSenderId;
  final String lastMessageId;
  const ChatEntity(
      {required this.senderUid,
      required this.recipientUid,
      this.senderName,
      required this.lastSenderId,
      this.recipientName,this.isBlockedByMe,
      required this.lastMessageId,
      required this.recentTextMessage,
      required this.createdAt,
      this.senderProfile,
      this.otherUserProfile,
      this.otherUserName,
      this.recipientProfile,
      this.totalUnReadMessages});

  @override
  List<Object?> get props => [
        senderUid,
        recipientUid,
        recipientName,
        otherUserProfile,
        otherUserName,
        recentTextMessage,
        createdAt,
        recipientProfile,
        totalUnReadMessages,isBlockedByMe,
        lastMessageId,
        lastSenderId
      ];
}
