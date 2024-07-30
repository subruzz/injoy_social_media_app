import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/chat/domain/repositories/chat_repository.dart';

class DeleteChatUsecase implements UseCase<Unit, DeleteChatUsecaseParams> {
  final ChatRepository _chatRepository;

  DeleteChatUsecase({required ChatRepository chatRepository})
      : _chatRepository = chatRepository;

  @override
  Future<Either<Failure, Unit>> call(DeleteChatUsecaseParams params) async {
    return await _chatRepository.deleteChat(
      params.myId,
    );
  }
}

class DeleteChatUsecaseParams {
  final String myId;

  DeleteChatUsecaseParams({
    required this.myId,
  });
}
