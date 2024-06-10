import 'dart:io';

import 'package:fpdart/src/either.dart';
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
  Future<Either<Failure, UserProfile>> createUserProfile(
      {required String fullName,
      required String userName,
      required String dob,
      int? phoneNumber,
      String? occupation,
      String? about,
      File? profilePic,
      String? location,
      double? latitude,
      double? longitude,
      List<String>? interests,
   }) async {
    try {
      UserProfileModel userProfileModel = UserProfileModel(
        fullName: fullName,
        userName: userName,
        dob: dob,
        phoneNumber: phoneNumber,
        occupation: occupation,
        about: about,
        profilePic: '',
        location: location,
        latitude: latitude,
        longitude: longitude,
        interests: interests,
      );
      try {
        final imageUrl =
            await _userProfileDataSource.uploadUserImage(profilePic);
        userProfileModel.profilePic=imageUrl;
      } catch (e) {
        // FirebaseStorage storage = FirebaseStorage.instance;
        // Reference ref = storage.ref().child('vendorImages').child(uid);
        // await ref.delete();
      }
      final createProfile = await _userProfileDataSource.createUserProfile(
          userProfile: userProfileModel);
      return right(createProfile);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }
}
