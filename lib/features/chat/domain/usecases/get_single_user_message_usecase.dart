import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/features/chat/domain/entities/message_entity.dart';
import 'package:social_media_app/features/chat/domain/repositories/chat_repository.dart';

class GetSingleUserMessageUsecase {
  final ChatRepository _chatRepository;

  GetSingleUserMessageUsecase({required ChatRepository chatRepository})
      : _chatRepository = chatRepository;

  Stream<Either<Failure, List<MessageEntity>>> call(
      String sendorId, String recipientId) {
    return _chatRepository.getSingleUserMessages(sendorId, recipientId);
  }
}
