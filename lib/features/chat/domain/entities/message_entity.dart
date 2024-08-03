import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/utils.dart';

class MessageEntity extends Equatable {
  final String senderUid;
  final String recipientUid;
  final String messageType;
  final String? message;
  final Timestamp? createdAt;
  final SelectedByte? assetPath;
  final String? assetLink;
  final bool isSeen;
  final String? repliedTo;
  final String? repliedMessage;
  final String? repliedMessageAssetLink;
  final String? repliedMessageType;
  final String messageId;
  final bool isDeleted;
  final bool? repliedToMe;
  final bool isEdited;
  final String? repliedMessgeCreatorId;
  final DateTime? deletedAt;

  const MessageEntity({
    required this.isDeleted,
    required this.isEdited,
    this.repliedToMe,
    this.repliedMessageAssetLink,
    this.repliedMessgeCreatorId,
    required this.deletedAt,
    required this.senderUid,
    this.assetLink,
    this.assetPath,
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
        assetPath,
        isDeleted,
        repliedMessgeCreatorId,
        senderUid,
        recipientUid,
        repliedToMe,
        assetLink,
        messageType,
        message,
        createdAt,
        repliedMessageAssetLink,
        isSeen,
        repliedTo,
        repliedMessage,
        repliedMessageType,
        messageId,
      ];
}
