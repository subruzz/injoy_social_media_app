import 'dart:io';

import 'package:fpdart/src/either.dart';
import 'package:social_media_app/core/common/entities/user.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/profile/data/data_source/user_profile_data_source.dart';
import 'package:social_media_app/features/profile/domain/repository/profile_repository.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  final UserProfileDataSource _userProfileDataSource;

  UserProfileRepositoryImpl(
      {required UserProfileDataSource userProfileDataSource})
      : _userProfileDataSource = userProfileDataSource;
  @override
  Future<Either<Failure, AppUser>> createUserProfile({
    required AppUser user,
    File? profilePic,
  }) async {
    try {
      try {
        final imageUrl =
            await _userProfileDataSource.uploadUserImage(profilePic);
        user.profilePic = imageUrl;
      } catch (e) {
        // FirebaseStorage storage = FirebaseStorage.instance;
        // Reference ref = storage.ref().child('vendorImages').child(uid);
        // await ref.delete();
      }
      final createProfile =
          await _userProfileDataSource.createUserProfile(userProfile: user);
      return right(createProfile);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }
}
