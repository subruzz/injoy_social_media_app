class MessageReplyEntity {
  final String? message;
  final String? username;
  final String? messageType;
  final bool? isMe;
  final String? repliedMessgeCreatorId;
  MessageReplyEntity({
    this.message,
    this.username,
    this.repliedMessgeCreatorId,
    this.messageType,
    this.isMe,
  });
}
