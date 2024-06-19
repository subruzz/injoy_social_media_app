import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/create_post/domain/enitities/post.dart';

abstract class UserPostsRepository {
  Future<Either<Failure, List<PostEntity>>> getAllPostsByUser(String userId);
}
