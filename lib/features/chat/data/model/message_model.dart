import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/features/chat/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel(
      {super.senderUid,
      super.recipientUid,
      super.senderName,
      super.recipientName,
      super.messageType,
      super.message,
      super.createdAt,
      super.isSeen,
      super.repliedTo,
      super.repliedMessage,
      super.repliedMessageType,
      super.messageId});

  factory MessageModel.fromJson(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;

    return MessageModel(
      senderUid: snap['senderUid'],
      senderName: snap['senderName'],
      recipientUid: snap['recipientUid'],
      recipientName: snap['recipientName'],
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
        "senderUid": senderUid,
        "senderName": senderName,
        "recipientUid": recipientUid,
        "recipientName": recipientName,
        "createdAt": createdAt,
        "isSeen": isSeen,
        "message": message,
        "messageType": messageType,
        "repliedMessage": repliedMessage,
        "repliedTo": repliedTo,
        "messageId": messageId,
        "repliedMessageType": repliedMessageType,
      };
}
