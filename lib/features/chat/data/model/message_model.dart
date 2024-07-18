
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/features/chat/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel(
      {required super.senderUid,
      required super.recipientUid,
      required super.messageType,
      super.message,
      super.createdAt,
      required super.isSeen,
      super.repliedTo,
      super.repliedMessage,
      super.repliedMessageType,
      required super.messageId,
      required super.isDeleted,
      required super.isEdited,
      required super.deletedAt});
  factory MessageModel.fromMessageEntity(MessageEntity entity) {
    return MessageModel(
      isDeleted: entity.isDeleted,
      isEdited: entity.isEdited,
      deletedAt: entity.deletedAt,
      senderUid: entity.senderUid,
      recipientUid: entity.recipientUid,
      createdAt: entity.createdAt,
      isSeen: entity.isSeen,
      message: entity.message,
      messageType: entity.messageType,
      repliedMessage: entity.repliedMessage,
      repliedTo: entity.repliedTo,
      messageId: entity.messageId,
      repliedMessageType: entity.repliedMessageType,
    );
  }
  factory MessageModel.fromJson(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;

    return MessageModel(
      isDeleted: snap['isDeleted'],
      isEdited: snap['isEdited'],
      deletedAt: snap['deleteAt'],
      senderUid: snap['senderUid'],
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

  Map<String, dynamic> toDocument() => {
        'isDeleted': isDeleted,
        'isEdited': isEdited,
        'deleteAt': deletedAt,
        "senderUid": senderUid,
        "recipientUid": recipientUid,
        "createdAt": createdAt ?? FieldValue.serverTimestamp(),
        "isSeen": isSeen,
        "message": message,
        "messageType": messageType,
        "repliedMessage": repliedMessage,
        "repliedTo": repliedTo,
        "messageId": messageId,
        "repliedMessageType": repliedMessageType,
      };
}
