import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/chat/domain/repositories/chat_repository.dart';


class DeleteSingleChatUseCase
    implements UseCase<Unit, DeleteSingleChatUseCaseParams> {
  final ChatRepository _chatRepository;

  DeleteSingleChatUseCase({required ChatRepository chatRepository})
      : _chatRepository = chatRepository;

  @override
  Future<Either<Failure, Unit>> call(
      DeleteSingleChatUseCaseParams params) async {
    return await _chatRepository.deleteChat(params.myId, params.otherUserId);
  }
}

class DeleteSingleChatUseCaseParams {
  final String myId;
  final String otherUserId;

  DeleteSingleChatUseCaseParams(
      {required this.myId, required this.otherUserId});
}
