// auth_repository.dart
import 'dart:io';
import 'dart:typed_data';

import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/profile/domain/entities/user_profile.dart';

abstract interface class UserProfileRepository {
  Future<Either<Failure, AppUser>> createUserProfile(
      {required UserProfile user,
      File? profilePic,
      Uint8List? webImage,
      required String uid,
      required bool isEdit});
  Future<Either<Failure, bool>> checkUserNameExist(String userName);
  Future<Either<Failure, Unit>> addInterest(List<String> interests, String uid);
}
