import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String senderUid;
  final String recipientUid;
  final String messageType;
  final String? message;
  final Timestamp? createdAt;
  final bool isSeen;
  final String? repliedTo;
  final String? repliedMessage;
  final String? repliedMessageType;
  final String messageId;
  final bool isDeleted;
  final bool isEdited;
  final DateTime? deletedAt;

  const MessageEntity({
    required this.isDeleted,
    required this.isEdited,
    required this.deletedAt,
    required this.senderUid,
    required this.recipientUid,
    required this.messageType,
    this.message,
    this.createdAt,
    required this.isSeen,
    this.repliedTo,
    this.repliedMessage,
    this.repliedMessageType,
    required this.messageId,
  });

  @override
  List<Object?> get props => [
        deletedAt,
        isEdited,
        isDeleted,
        senderUid,
        recipientUid,
        messageType,
        message,
        createdAt,
        isSeen,
        repliedTo,
        repliedMessage,
        repliedMessageType,
        messageId,
      ];
}
