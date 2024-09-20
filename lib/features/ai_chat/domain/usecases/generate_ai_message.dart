import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/ai_chat/domain/enitity/ai_chat_entity.dart';
import 'package:social_media_app/features/ai_chat/domain/repository/ai_chat_repository.dart';

class GenerateAiMessageUseCase
    implements UseCase<String, GenerateAiMessageUseCaseParams> {
  final AiChatRepository _aiChatRepository;

  GenerateAiMessageUseCase({required AiChatRepository aiChatRepository})
      : _aiChatRepository = aiChatRepository;

  @override
  Future<Either<Failure, String>> call(
      GenerateAiMessageUseCaseParams params) async {
    return await _aiChatRepository.sendAndGetChat(
        params.previousMessages, params.message);
  }
}

class GenerateAiMessageUseCaseParams {
  final String message;
  final List<AiChatEntity> previousMessages;
  GenerateAiMessageUseCaseParams(this.previousMessages,
      {required this.message});
}
