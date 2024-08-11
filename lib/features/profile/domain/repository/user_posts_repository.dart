import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/entities/post.dart';


abstract class UserPostsRepository {
  Future<
          Either<Failure,
              ({List<PostEntity> userPosts, List<String> userPostImages})>>
      getAllPostsByUser(PartialUser user);
  Future<Either<Failure, List<PostEntity>>> getMyLikedPosts(String userId);
  Future<Either<Failure, List<PostEntity>>> getShorts(PartialUser user);
}
