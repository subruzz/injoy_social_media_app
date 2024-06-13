// auth_repository.dart
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/user.dart';
import 'package:social_media_app/core/errors/failure.dart';

abstract interface class UserProfileRepository {
  Future<Either<Failure, AppUser>> createUserProfile({
    required AppUser user,
    File? profilePic,
  });
}
