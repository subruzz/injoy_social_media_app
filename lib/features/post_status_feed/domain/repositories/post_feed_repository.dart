import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/common/entities/status_entity.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/create_status/domain/entities/single_status_entity.dart';

abstract class PostFeedRepository {
  Future<Either<Failure, List<PostEntity>>> fetchFollowedPosts(String userId);
  Future<Either<Failure, List<PostEntity>>> fetchSuggestedPosts(String userId);
  Future<Either<Failure, StatusUserStatus>> fetchCurrentUserStatus(
      String userId);
  Future<Either<Failure, List<StatusUserStatus>>>
      fetchCurrentUserAndFollowingStatuses(String currentUserId);
}
