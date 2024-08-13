import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/features/profile/data/data_source/user_data_remote_datasource.dart';
import 'package:social_media_app/features/profile/domain/repository/user_dat_repository.dart';

class UserDataRepoImpl implements UserDatRepository {
  final UserDataDatasource _userDataDatasource;

  UserDataRepoImpl(
      {required UserDataDatasource userPostsRemoteDataSource})
      : _userDataDatasource = userPostsRemoteDataSource;
  @override
  Future<Either<Failure, List<PostEntity>>> getAllPostsByUser(
      PartialUser user) async {
    try {
      final result = await _userDataDatasource.getAllPostsByUser(user);
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
  Future<Either<Failure, List<PartialUser>>> getMyFollowersList(
      String myId) async {
    try {
      final res = await _userDataDatasource.getMyFollowers(myId);
      return right(res);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg, e.details));
    }
  }

  @override
  Future<Either<Failure, List<PartialUser>>> getMyFollowingList(
      List<String> following, String myId) async {
    try {
      final res = await _userDataDatasource.getMyFollowing(following, myId);
      return right(res);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg, e.details));
    }
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getMyLikedPosts(
      String userId) async {
    try {
      final res = await _userDataDatasource.getMyLikedPosts(userId);
      return right(res);
    } on MainException catch (e) {
      return left(
        Failure(e.errorMsg),
      );
    }
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getShorts(PartialUser user) async {
    try {
      final res = await _userDataDatasource.getShorts(user);
      return right(res);
    } on MainException catch (e) {
      return left(
        Failure(e.errorMsg),
      );
    }
  }
}
