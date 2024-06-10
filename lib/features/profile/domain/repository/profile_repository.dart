// auth_repository.dart
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/profile/domain/entities/user_profile.dart';

abstract interface class UserProfileRepository {
  Future<Either<Failure, UserProfile>> createUserProfile({
    required String fullName,
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
  });
}
