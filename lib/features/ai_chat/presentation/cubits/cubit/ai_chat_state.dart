part of 'ai_chat_cubit.dart';

sealed class AiChatState extends Equatable {
  const AiChatState();

  @override
  List<Object> get props => [];
}

final class AiChatInitial extends AiChatState {}

final class AiChatLoading extends AiChatState {}

final class AiChatSuccess extends AiChatState {
  final List<AiChatEntity> chatMessages;

  const AiChatSuccess({required this.chatMessages});
  @override
  List<Object> get props => [chatMessages];
}

final class AiChatFailure extends AiChatState {}
