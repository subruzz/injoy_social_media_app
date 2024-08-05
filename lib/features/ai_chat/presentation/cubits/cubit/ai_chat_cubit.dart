import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/ai_chat/domain/enitity/ai_chat_entity.dart';
import 'package:social_media_app/features/ai_chat/domain/usecases/generate_ai_message.dart';

part 'ai_chat_state.dart';

class AiChatCubit extends Cubit<AiChatState> {
  final GenerateAiMessageUseCase _aiMessageUseCase;
  AiChatCubit(this._aiMessageUseCase) : super(AiChatInitial());
  final List<AiChatEntity> aiChatMessages = [];

  void chatGenerateNewTextMessage(String chatMsg) async {
    aiChatMessages.add(
      AiChatEntity(
        role: 'user',
        parts: [ChatPartModel(text: chatMsg)],
      ),
    );
    emit(AiChatSuccess(chatMessages: aiChatMessages));
    emit(AiChatLoading());
    final res = await _aiMessageUseCase(
        GenerateAiMessageUseCaseParams(aiChatMessages, message: chatMsg));
    res.fold((failure) {
      log('ai chat error');
      aiChatMessages.removeLast();
      emit(AiChatFailure());
    }, (success) {
      log('ai chat success');

      aiChatMessages.add(
          AiChatEntity(role: 'model', parts: [ChatPartModel(text: success)]));
    });
  }
}
