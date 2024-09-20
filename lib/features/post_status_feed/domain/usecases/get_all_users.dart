import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/post_status_feed/domain/repositories/post_feed_repository.dart';

class GetAllUsersUseCase
    implements UseCase<List<PartialUser>, GetAllUsersUseCaseParams> {
  final PostFeedRepository _postFeedRepository;

  GetAllUsersUseCase({required PostFeedRepository postFeedRepository})
      : _postFeedRepository = postFeedRepository;

  @override
  Future<Either<Failure, List<PartialUser>>> call(
      GetAllUsersUseCaseParams params) async {
    return await _postFeedRepository.getAllUser(
        id: params.uId, following: params.following);
  }
}

class GetAllUsersUseCaseParams {
  final String uId;
  final List<String> following;

  GetAllUsersUseCaseParams({required this.uId, required this.following});
}
