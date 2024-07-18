part of 'message_cubit.dart';

sealed class MessageState extends Equatable {
  const MessageState();

  @override
  List<Object> get props => [];
}

final class MessageInitial extends MessageState {}

class MessageLoading extends MessageState {
  @override
  List<Object> get props => [];
}

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
