import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  final String senderUid;
  final String recipientUid;
  final String? senderName;
  final String? recipientName;
  final String recentTextMessage;
  final Timestamp createdAt;
  final String? senderProfile;
  final String? recipientProfile;
  final num? totalUnReadMessages;

  const ChatEntity(
      {required this.senderUid,
      required this.recipientUid,
      this.senderName,
      this.recipientName,
      required this.recentTextMessage,
      required this.createdAt,
      this.senderProfile,
      this.recipientProfile,
      this.totalUnReadMessages});

  @override
  List<Object?> get props => [
        senderUid,
        recipientUid,
        recipientName,
        recentTextMessage,
        createdAt,
        recipientProfile,
        totalUnReadMessages
      ];
}
