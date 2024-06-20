import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/entities/post.dart';

abstract class UserPostsRepository {
  Future<
          Either<Failure,
              ({List<PostEntity> userPosts, List<String> userPostImages})>>
      getAllPostsByUser(String userId);
}
