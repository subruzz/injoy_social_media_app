import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/chat/domain/entities/chat_entity.dart';
import 'package:social_media_app/features/chat/domain/entities/message_entity.dart';
import 'package:social_media_app/features/chat/domain/repositories/chat_repository.dart';

class SendMessageUseCase implements UseCase<Unit, SendMessageUseCaseParams> {
  final ChatRepository _chatRepository;

  SendMessageUseCase({required ChatRepository chatRepository})
      : _chatRepository = chatRepository;

  @override
  Future<Either<Failure, Unit>> call(SendMessageUseCaseParams params) async {
    return await _chatRepository.sendMessage(params.chat, params.message);
  }
}

class SendMessageUseCaseParams {
  final ChatEntity chat;
  final MessageEntity message;

  SendMessageUseCaseParams({required this.chat, required this.message});
}
