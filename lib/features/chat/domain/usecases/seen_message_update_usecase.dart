import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/chat/domain/entities/message_entity.dart';
import 'package:social_media_app/features/chat/domain/repositories/chat_repository.dart';

class SeenMessageUpdateUsecase
    implements UseCase<Unit, SeenMessageUpdateUsecaseParams> {
  final ChatRepository _chatRepository;

  SeenMessageUpdateUsecase({required ChatRepository chatRepository})
      : _chatRepository = chatRepository;

  @override
  Future<Either<Failure, Unit>> call(
      SeenMessageUpdateUsecaseParams params) async {
    return await _chatRepository.seenMessageUpdate(
        params.sendorId, params.recieverId, params.messageId);
  }
}

class SeenMessageUpdateUsecaseParams {
  final String sendorId;
  final String recieverId;
  final String messageId;

  SeenMessageUpdateUsecaseParams(
      {required this.sendorId,
      required this.recieverId,
      required this.messageId});
}
