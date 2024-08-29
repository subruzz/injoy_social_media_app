import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/chat/domain/repositories/chat_repository.dart';


class BlockUnblockChatUseCase
    implements UseCase<Unit, BlockUnblockChatUseCaseParams> {
  final ChatRepository _chatRepository;

  BlockUnblockChatUseCase({required ChatRepository chatRepository})
      : _chatRepository = chatRepository;

  @override
  Future<Either<Failure, Unit>> call(
      BlockUnblockChatUseCaseParams params) async {
    return await _chatRepository.blockAndUnblockChat(
        params.myId, params.otherUserId, params.isBlock);
  }
}

class BlockUnblockChatUseCaseParams {
  final String myId;
  final String otherUserId;
  final bool isBlock;

  BlockUnblockChatUseCaseParams(
      {required this.myId, required this.otherUserId, required this.isBlock});
}
