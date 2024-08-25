import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/chat/domain/repositories/chat_repository.dart';

import '../entities/message_entity.dart';

class DeleteMessageUsecase
    implements UseCase<Unit, DeleteMessageUsecaseParams> {
  final ChatRepository _chatRepository;

  DeleteMessageUsecase({required ChatRepository chatRepository})
      : _chatRepository = chatRepository;

  @override
  Future<Either<Failure, Unit>> call(DeleteMessageUsecaseParams params) async {
    return await _chatRepository.deleteMessage(params.messages);
  }
}

class DeleteMessageUsecaseParams {
  final List<MessageEntity> messages;

  DeleteMessageUsecaseParams({required this.messages});
}
