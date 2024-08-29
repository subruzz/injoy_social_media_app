import 'dart:io';
import 'dart:typed_data';

import 'package:fpdart/fpdart.dart';
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
        user: params.appUser,
        webImage: params.webImage,
        profilePic: params.profilePic,
        uid: params.uid,
        isEdit: params.isEdit);
  }
}

class CreateUserProfileUseCaseParams {
  final UserProfile appUser;
  File? profilePic;
  Uint8List? webImage;

  final String uid;
  final bool isEdit;
  CreateUserProfileUseCaseParams({
    required this.appUser,
    this.webImage,
    required this.uid,
    required this.isEdit,
    required this.profilePic,
  });
}
