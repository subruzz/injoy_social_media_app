import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/ai_chat/domain/enitity/ai_chat_entity.dart';
import 'package:social_media_app/features/ai_chat/domain/usecases/generate_ai_message.dart';

part 'ai_chat_state.dart';

class AiChatCubit extends Cubit<AiChatState> {
  final GenerateAiMessageUseCase _aiMessageUseCase;

  AiChatCubit(this._aiMessageUseCase) : super(const AiChatState());
  void clearChat() {
    if (state.chatMessages.isEmpty || state.isLoading) {
      return;
    }
    state.chatMessages.clear();
    log(state.chatMessages.toString());
    emit(state.copyWith(chatMessages: state.chatMessages));
  }

  void chatGenerateNewTextMessage(String chatMsg) async {
    // Add the new user message
    final newUserMessage = AiChatEntity(
      role: 'user',
      parts: [ChatPartModel(text: chatMsg)],
    );

    // Emit the new state with the new user message and set loading to true
    emit(state.copyWith(
      chatMessages: List.from(state.chatMessages)..add(newUserMessage),
      isLoading: true,
      isError: false,
    ));

    final res = await _aiMessageUseCase(
      GenerateAiMessageUseCaseParams(state.chatMessages, message: chatMsg),
    );

    res.fold(
      (failure) {
        log('ai chat error');
        // Remove the user message in case of failure and set error state
        emit(state.copyWith(
          chatMessages: List.from(state.chatMessages)..removeLast(),
          isLoading: false,
          isError: true,
        ));
      },
      (success) {
        log('ai chat success');
        final aiMessage = AiChatEntity(
          role: 'model',
          parts: [ChatPartModel(text: success)],
        );

        // Add the AI-generated message and set success state
        emit(state.copyWith(
          chatMessages: List.from(state.chatMessages)..add(aiMessage),
          isLoading: false,
          isError: false,
        ));
      },
    );
  }

  void init() {
    emit(const AiChatState());
  }
}
