import 'dart:io';

import 'package:fpdart/src/either.dart';
import 'package:social_media_app/core/common/entities/user.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/usecases/usecase.dart';
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
      user: params.appUser,
      profilePic: params.profilePic,
    );
  }
}

class CreateUserProfileUseCaseParams {
  final AppUser appUser;
  File? profilePic;

  CreateUserProfileUseCaseParams({
    required this.appUser,
    required this.profilePic,
  });
}
