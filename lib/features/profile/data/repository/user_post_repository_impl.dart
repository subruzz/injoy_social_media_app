import 'package:fpdart/src/either.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/create_post/domain/enitities/post.dart';
import 'package:social_media_app/features/profile/data/data_source/user_posts_remote_datasource.dart';
import 'package:social_media_app/features/profile/domain/repository/user_posts_repository.dart';

class UserPostRepositoryImpl implements UserPostsRepository {
  final UserPostsRemoteDataSource _userPostsRemoteDataSource;

  UserPostRepositoryImpl(
      {required UserPostsRemoteDataSource userPostsRemoteDataSource})
      : _userPostsRemoteDataSource = userPostsRemoteDataSource;
  @override
  Future<Either<Failure, List<PostEntity>>> getAllPostsByUser(
      String userId) async {
    try {
      final result = await _userPostsRemoteDataSource.getAllPostsByUser(userId);
      return right(result);
    } on MainException catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }
}
