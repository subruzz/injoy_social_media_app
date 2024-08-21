import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/features/chat/domain/entities/message_entity.dart';
import 'package:social_media_app/core/services/assets/asset_model.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.senderUid,
    required super.recipientUid,
    required super.messageType,
    super.message,
    super.createdAt,
    super.assetPath,
    super.isItReply,
    required super.isSeen,
    super.repliedTo,
    super.assetLink,
    super.repliedToMe,
    super.repliedMessage,
    super.repliedMessageType,
    super.repliedMessageAssetLink,
    required super.messageId,
    required super.isDeleted,
    required super.isEdited,
    required super.deletedAt,
    super.repliedMessgeCreatorId,
  });

  factory MessageModel.fromMessageEntity(MessageEntity entity) {
    return MessageModel(
      repliedMessageAssetLink: entity.repliedMessageAssetLink,
      isDeleted: entity.isDeleted,
      isEdited: entity.isEdited,
      isItReply: entity.isItReply,
      deletedAt: entity.deletedAt,
      senderUid: entity.senderUid,
      recipientUid: entity.recipientUid,
      createdAt: entity.createdAt,
      repliedMessgeCreatorId: entity.repliedMessgeCreatorId,
      isSeen: entity.isSeen,
      message: entity.message,
      messageType: entity.messageType,
      repliedMessage: entity.repliedMessage,
      repliedTo: entity.repliedTo,
      assetPath: entity.assetPath,
      messageId: entity.messageId,
      repliedToMe: entity.repliedToMe,
      repliedMessageType: entity.repliedMessageType,
    );
  }

  factory MessageModel.fromJson(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;

    return MessageModel(
      repliedMessageAssetLink: snap['repliedMessageAssetLink'],
      assetLink: snap['assetLink'],
      isDeleted: snap['isDeleted'],
      isEdited: snap['isEdited'],
      isItReply: snap['isItReply'] ?? false,
      deletedAt: snap['deleteAt'],
      senderUid: snap['senderUid'],
      repliedToMe: snap['repliedToMe'],
      repliedMessgeCreatorId: snap['repliedMessgeCreatorId'],
      recipientUid: snap['recipientUid'],
      createdAt: snap['createdAt'],
      isSeen: snap['isSeen'],
      message: snap['message'],
      messageType: snap['messageType'],
      repliedMessage: snap['repliedMessage'],
      repliedTo: snap['repliedTo'],
      messageId: snap['messageId'],
      repliedMessageType: snap['repliedMessageType'],
    );
  }

  Map<String, dynamic> toDocument({required FieldValue time}) => {
        'repliedMessageAssetLink': repliedMessageAssetLink,
        'isDeleted': isDeleted,
        'isEdited': isEdited,
        'isItReply': isItReply,
        'assetLink': assetLink,
        'deleteAt': deletedAt,
        'senderUid': senderUid,
        'repliedMessgeCreatorId': repliedMessgeCreatorId,
        'recipientUid': recipientUid,
        'createdAt': time,
        'isSeen': isSeen,
        'message': message,
        'messageType': messageType,
        'repliedMessage': repliedMessage,
        'repliedTo': repliedTo,
        'messageId': messageId,
        'repliedMessageType': repliedMessageType,
      };

  // Add the copyWith method
  MessageModel copyWith({
    String? senderUid,
    String? recipientUid,
    String? repliedMessageAssetLink,
    String? messageType,
    String? assetLink,
    String? message,
    Timestamp? createdAt,
    SelectedByte? assetPath,
    bool? isSeen,
    bool? repliedToMe,
    String? repliedTo,
    bool? isItReply,
    String? repliedMessage,
    String? repliedMessageType,
    String? messageId,
    bool? isDeleted,
    bool? isEdited,
    bool? isThisreply,
    DateTime? deletedAt,
  }) {
    return MessageModel(
        repliedMessageAssetLink:
            repliedMessageAssetLink ?? this.repliedMessageAssetLink,
        senderUid: senderUid ?? this.senderUid,
        recipientUid: recipientUid ?? this.recipientUid,
        messageType: messageType ?? this.messageType,
        message: message ?? this.message,
        createdAt: createdAt ?? this.createdAt,
        isItReply: isItReply ?? this.isItReply,
        repliedToMe: repliedToMe ?? this.repliedToMe,
        assetPath: assetPath ?? this.assetPath,
        isSeen: isSeen ?? this.isSeen,
        repliedTo: repliedTo ?? this.repliedTo,
        repliedMessage: repliedMessage ?? this.repliedMessage,
        repliedMessageType: repliedMessageType ?? this.repliedMessageType,
        messageId: messageId ?? this.messageId,
        isDeleted: isDeleted ?? this.isDeleted,
        isEdited: isEdited ?? this.isEdited,
        deletedAt: deletedAt ?? this.deletedAt,
        assetLink: assetLink ?? this.assetLink);
  }
}
