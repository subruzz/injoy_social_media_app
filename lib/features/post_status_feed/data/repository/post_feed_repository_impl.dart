import 'package:fpdart/src/either.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/post_status_feed/data/datasource/post_feed_remote_datasource.dart';
import 'package:social_media_app/features/post_status_feed/domain/repositories/post_feed_repository.dart';

class PostFeedRepositoryImpl implements PostFeedRepository {
  final PostFeedRemoteDatasource _feedRemoteDatasource;

  PostFeedRepositoryImpl(
      {required PostFeedRemoteDatasource feedRemoteDatasource})
      : _feedRemoteDatasource = feedRemoteDatasource;
  @override
  Future<Either<Failure, List<PostEntity>>> fetchFollowedPosts(
      String userId) async {
    try {
      final result = await _feedRemoteDatasource.fetchFollowedPosts(userId);
      return right(result);
    } on MainException catch (e) {
      return left(
        Failure(
          e.errorMsg,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<PostEntity>>> fetchSuggestedPosts(String userId) {
    // TODO: implement fetchSuggestedPosts
    throw UnimplementedError();
  }

 
}
