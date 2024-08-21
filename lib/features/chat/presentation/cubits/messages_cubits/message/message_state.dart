part of 'message_cubit.dart';

sealed class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object?> get props => [];
}

final class MessageInitial extends MessageState {}

class MessageLoading extends MessageState {
  @override
  List<Object> get props => [];
}

final class MessageSuccess extends MessageState {}

class MessageLoaded extends MessageState {
  final List<MessageEntity> messages;

  const MessageLoaded({required this.messages});
  @override
  List<Object> get props => [messages];
}

class MessageFailure extends MessageState {
  final String errorMsg;

  const MessageFailure({required this.errorMsg});
  @override
  List<Object> get props => [errorMsg];
}

class VoiceMessageOngoing extends MessageState {
  final int durration;

  const VoiceMessageOngoing({required this.durration});
}

class VoiceMessageStarted extends MessageState {}

class VoiceMessageStopped extends MessageState {}

class ShowVoiceMessageIcon extends MessageState {}

final class MessageReplyClicked extends MessageState {
  final bool repliedToMe;
  final String messageType;
  final String? assetPath;
  final String? caption;
  final String userName;
  final String repliedMessageCreator;
  const MessageReplyClicked(
      {required this.repliedToMe,
      required this.messageType,
      required this.assetPath,
      required this.userName,
      required this.repliedMessageCreator,
      required this.caption});
  @override
  List<Object?> get props =>
      [repliedToMe, messageType, caption, assetPath, userName];
}

final class MessageReplyRemoved extends MessageState {}
