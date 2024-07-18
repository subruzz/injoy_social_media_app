import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/chat/domain/entities/chat_entity.dart';
import 'package:social_media_app/features/chat/domain/repositories/chat_repository.dart';

class DeleteChatUsecase implements UseCase<Unit, DeleteChatUsecaseParams> {
  final ChatRepository _chatRepository;

  DeleteChatUsecase({required ChatRepository chatRepository})
      : _chatRepository = chatRepository;

  @override
  Future<Either<Failure, Unit>> call(DeleteChatUsecaseParams params) async {
    return await _chatRepository.deleteChat(
      params.chat,
    );
  }
}

class DeleteChatUsecaseParams {
  final ChatEntity chat;

  DeleteChatUsecaseParams({
    required this.chat,
  });
}
