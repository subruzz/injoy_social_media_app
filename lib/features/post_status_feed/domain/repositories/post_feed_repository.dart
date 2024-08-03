import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/post_status_feed/domain/usecases/get_following_posts.dart';

import '../../../../core/common/models/partial_user_model.dart';

abstract class PostFeedRepository {
  Future<Either<Failure, PostsResult>> fetchFollowedPosts(
      String userId, List<String> following,
      {DocumentSnapshot? lastDoc, int limit = 4});
  Future<Either<Failure, List<PostEntity>>> fetchSuggestedPosts(AppUser user);
  Future<Either<Failure, List<PartialUser>>> getAllUser(
      {required String id, required List<String> following});
}
