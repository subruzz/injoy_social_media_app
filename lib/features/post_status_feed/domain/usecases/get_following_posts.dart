import 'package:fpdart/src/either.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/usecases/usecase.dart';
import 'package:social_media_app/features/post_status_feed/domain/repositories/post_feed_repository.dart';

class GetFollowingPostsUseCase
    implements UseCase<List<PostEntity>, GetFollowingPostsUseCaseParams> {
  final PostFeedRepository _postFeedRepository;

  GetFollowingPostsUseCase({required PostFeedRepository postFeedRepository})
      : _postFeedRepository = postFeedRepository;
  @override
  Future<Either<Failure, List<PostEntity>>> call(
      GetFollowingPostsUseCaseParams params) async {
    return await _postFeedRepository.fetchFollowedPosts(params.uId);
  }
}

class GetFollowingPostsUseCaseParams {
  final String uId;

  GetFollowingPostsUseCaseParams({required this.uId});
}
