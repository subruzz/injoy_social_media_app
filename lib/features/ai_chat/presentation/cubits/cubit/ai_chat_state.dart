part of 'ai_chat_cubit.dart';

class AiChatState extends Equatable {
  final List<AiChatEntity> chatMessages;
  final bool isLoading;
  final bool isError;

  const AiChatState({
    this.chatMessages = const [],
    this.isLoading = false,
    this.isError = false,
  });

  AiChatState copyWith({
    List<AiChatEntity>? chatMessages,
    bool? isLoading,
    bool? isError,
  }) {
    return AiChatState(
      chatMessages: chatMessages ?? this.chatMessages,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
    );
  }

  @override
  List<Object> get props => [chatMessages, isLoading, isError];
}
