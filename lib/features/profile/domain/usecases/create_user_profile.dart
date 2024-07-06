import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:fpdart/src/either.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/profile/domain/entities/user_profile.dart';
import 'package:social_media_app/features/profile/domain/repository/profile_repository.dart';

class CreateUserProfileUseCase
    implements UseCase<AppUser, CreateUserProfileUseCaseParams> {
  final UserProfileRepository _profileRepository;

  CreateUserProfileUseCase({required UserProfileRepository profileRepository})
      : _profileRepository = profileRepository;

  @override
  Future<Either<Failure, AppUser>> call(
      CreateUserProfileUseCaseParams params) async {
    return await _profileRepository.createUserProfile(
        user: params.appUser, profilePic: params.profilePic, uid: params.uid);
  }
}

class CreateUserProfileUseCaseParams {
  final UserProfile appUser;
  File? profilePic;
  final String uid;

  CreateUserProfileUseCaseParams({
    required this.appUser,
    required this.uid,
    required this.profilePic,
  });
}
