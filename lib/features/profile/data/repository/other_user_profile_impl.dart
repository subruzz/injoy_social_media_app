import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/common/models/post_model.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/profile/data/data_source/other_user_data_source.dart';
import 'package:social_media_app/features/profile/domain/repository/other_user_repository.dart';

class OtherUserProfileRepositoryImpl implements OtherUserRepository {
  final OtherUserDataSource _otherUserDataSource;

  OtherUserProfileRepositoryImpl(
      {required OtherUserDataSource otherUserDataSource})
      : _otherUserDataSource = otherUserDataSource;
  @override
  Future<Either<Failure, AppUser>> getOtherUserProfile(String uid) async {
    try {
      final res = await _otherUserDataSource.getOtherUserProfile(uid);
      return right(res);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }

  @override
  Future<Either<Failure, Unit>> followUser(
    String currentUid,
    String otherUid,
  ) async {
    try {
      await _otherUserDataSource.followUser(currentUid, otherUid);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }

  @override
  Future<Either<Failure, Unit>> unfollowUser(
    String currentUid,
    String otherUid,
  ) async {
    try {
      await _otherUserDataSource.unfollowUser(
        currentUid,
        otherUid,
      );
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }

  @override
  Future<
          Either<Failure,
              ({List<String> userPostImages, List<PostModel> userPosts})>>
      getAllPostsByOtherUser(String userId) async {
    try {
      final res = await _otherUserDataSource.getAllPostsByOtherUser(userId);
      return right(res);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg, e.details));
    }
  }

  @override
  Future<Either<Failure, List<PartialUser>>> getMyFollowersList(
      String myId) async {
    try {
      final res = await _otherUserDataSource.getMyFollowers(myId);
      return right(res);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg, e.details));
    }
  }

  @override
  Future<Either<Failure, List<PartialUser>>> getMyFollowingList(
      List<String> following, String myId) async {
    try {
      final res = await _otherUserDataSource.getMyFollowing(following, myId);
      return right(res);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg, e.details));
    }
  }
}
