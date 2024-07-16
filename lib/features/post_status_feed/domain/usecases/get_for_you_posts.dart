import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/post_status_feed/domain/repositories/post_feed_repository.dart';

class GetForYouPostsUseCase
    implements UseCase<List<PostEntity>, GetForYouPostsUseCaseParams> {
  final PostFeedRepository _postFeedRepository;

  GetForYouPostsUseCase({required PostFeedRepository postFeedRepository})
      : _postFeedRepository = postFeedRepository;
  @override
  Future<Either<Failure, List<PostEntity>>> call(
      GetForYouPostsUseCaseParams params) async {
    return await _postFeedRepository.fetchSuggestedPosts(params.user);
  }
}

class GetForYouPostsUseCaseParams {
  final AppUser user;
  GetForYouPostsUseCaseParams({required this.user});
}
