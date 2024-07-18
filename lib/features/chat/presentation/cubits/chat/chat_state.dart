part of 'chat_cubit.dart';

sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatLoaded extends ChatState {
  final List<ChatEntity> chatItems;

  const ChatLoaded({required this.chatItems});
  @override
  List<Object> get props => [chatItems];
}

class ChatFailure extends ChatState {
  final String errorMsg;

  const ChatFailure({required this.errorMsg});
  @override
  List<Object> get props => [];
}
