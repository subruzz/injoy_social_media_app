import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/chat/domain/entities/chat_entity.dart';
import 'package:social_media_app/features/chat/domain/repositories/chat_repository.dart';

class GetMyChatsUsecase {
  final ChatRepository _chatRepository;

  GetMyChatsUsecase({required ChatRepository chatRepository})
      : _chatRepository = chatRepository;

  Stream<Either<Failure, List<ChatEntity>>> call(ChatEntity chat) {
    return _chatRepository.getMyChat(chat);
  }
}
