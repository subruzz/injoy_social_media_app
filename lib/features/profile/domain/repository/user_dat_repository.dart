import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/entities/post.dart';

abstract class UserDatRepository {
  Future<Either<Failure, List<PostEntity>>> getAllPostsByUser(PartialUser user);
  Future<Either<Failure, List<PostEntity>>> getMyLikedPosts(String userId);
  Future<Either<Failure, List<PostEntity>>> getShorts(PartialUser user);

  Future<Either<Failure, List<PartialUser>>> getMyFollowingList(
      List<String> following, String myId);
  Future<Either<Failure, List<PartialUser>>> getMyFollowersList(String myId);
}
