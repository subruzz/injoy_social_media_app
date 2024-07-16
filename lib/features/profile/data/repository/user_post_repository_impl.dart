import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/features/profile/data/data_source/user_posts_remote_datasource.dart';
import 'package:social_media_app/features/profile/domain/repository/user_posts_repository.dart';

class UserPostRepositoryImpl implements UserPostsRepository {
  final UserPostsRemoteDataSource _userPostsRemoteDataSource;

  UserPostRepositoryImpl(
      {required UserPostsRemoteDataSource userPostsRemoteDataSource})
      : _userPostsRemoteDataSource = userPostsRemoteDataSource;
  @override
  Future<
          Either<Failure,
              ({List<PostEntity> userPosts, List<String> userPostImages})>>
      getAllPostsByUser(String userId) async {
    try {
      final result = await _userPostsRemoteDataSource.getAllPostsByUser(userId);
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
  Future<Either<Failure, List<PostEntity>>> getMyLikedPosts(
      String userId) async {
    try {
      final res = await _userPostsRemoteDataSource.getMyLikedPosts(userId);
      return right(res);
    } on MainException catch (e) {
      return left(
        Failure(e.errorMsg),
      );
    }
  }
}
