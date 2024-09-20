import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/post_status_feed/domain/repositories/post_feed_repository.dart';

class GetFollowingPostsUseCase
    implements UseCase<PostsResult, GetFollowingPostsUseCaseParams> {
  final PostFeedRepository _postFeedRepository;

  GetFollowingPostsUseCase({required PostFeedRepository postFeedRepository})
      : _postFeedRepository = postFeedRepository;
  @override
  Future<Either<Failure, PostsResult>> call(
      GetFollowingPostsUseCaseParams params) async {
    return await _postFeedRepository.fetchFollowedPosts(
        params.uId, params.following,
        lastDoc: params.lastDoc, limit: params.limit);
  }
}

class GetFollowingPostsUseCaseParams {
  final String uId;
  final DocumentSnapshot? lastDoc;
  final int limit;
  final List<String> following;

  GetFollowingPostsUseCaseParams(
      {required this.uId,
      required this.lastDoc,
      required this.limit,
      required this.following});
}

class PostsResult {
  final List<PostEntity> posts;
  final bool hasMore;
  final DocumentSnapshot? lastDoc;
  PostsResult(
      {required this.posts, required this.hasMore, required this.lastDoc});
}
