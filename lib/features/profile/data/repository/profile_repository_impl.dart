import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:fpdart/src/either.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/profile/data/data_source/user_profile_data_source.dart';
import 'package:social_media_app/features/profile/data/model/user_profile_model.dart';
import 'package:social_media_app/features/profile/domain/entities/user_profile.dart';
import 'package:social_media_app/features/profile/domain/repository/profile_repository.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  final UserProfileDataSource _userProfileDataSource;

  UserProfileRepositoryImpl(
      {required UserProfileDataSource userProfileDataSource})
      : _userProfileDataSource = userProfileDataSource;

  @override
  Future<Either<Failure, bool>> checkUserNameExist(String userName) async {
    try {
      final res = await _userProfileDataSource.checkUserNameExist(userName);
      return right(res);
    } on MainException catch (e) {
      return left(
        Failure(e.errorMsg, e.details),
      );
    }
  }

  @override
  Future<Either<Failure, AppUser>> createUserProfile(
      {required UserProfile user,
      File? profilePic,
      required String uid,
      required bool isEdit}) async {
    try {
      final userProfileModel = UserProfileModel.fromUserProfile(user);

      final res = await _userProfileDataSource.createUserProfile(
        userProfile: userProfileModel,
        uid: uid,
        file: profilePic,
        isEdit: isEdit
      );
      return right(res);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg, e.details));
    }
  }

  @override
  Future<Either<Failure, Unit>> addInterest(
      List<String> interests, String uid) async {
    try {
      await _userProfileDataSource.editInterest(interests, uid);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }
}
