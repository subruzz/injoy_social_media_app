import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/utils/errors/exception.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/features/post_status_feed/data/datasource/post_feed_remote_datasource.dart';
import 'package:social_media_app/features/post_status_feed/domain/repositories/post_feed_repository.dart';
import 'package:social_media_app/features/post_status_feed/domain/usecases/get_following_posts.dart';

class PostFeedRepositoryImpl implements PostFeedRepository {
  final PostFeedRemoteDatasource _feedRemoteDatasource;

  PostFeedRepositoryImpl(
      {required PostFeedRemoteDatasource feedRemoteDatasource})
      : _feedRemoteDatasource = feedRemoteDatasource;

  @override
  Future<Either<Failure, List<PostEntity>>> fetchSuggestedPosts(
      AppUser user) async {
    try {
      final result = await _feedRemoteDatasource.fetchSuggestedPosts(user);
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
  Future<Either<Failure, PostsResult>> fetchFollowedPosts(
      String userId, List<String> following,
      {DocumentSnapshot<Object?>? lastDoc, int limit = 4}) async {
    try {
      final result = await _feedRemoteDatasource.fetchFollowedPosts(
          userId, following,
          lastDoc: lastDoc, limit: limit);
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
  Future<Either<Failure, List<PartialUser>>> getAllUser(
      {required String id, required List<String> following}) async {
    try {
      final result =
          await _feedRemoteDatasource.getAllUser(id: id, following: following);
      return right(result);
    } on MainException catch (e) {
      return left(
        Failure(
          e.errorMsg,
        ),
      );
    }
  }
}
