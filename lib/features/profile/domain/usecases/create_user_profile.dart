import 'dart:io';

import 'package:fpdart/src/either.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/usecases/usecase.dart';
import 'package:social_media_app/features/profile/domain/entities/user_profile.dart';
import 'package:social_media_app/features/profile/domain/repository/profile_repository.dart';

class CreateUserProfileUseCase
    implements UseCase<UserProfile, CreateUserProfileUseCaseParams> {
  final UserProfileRepository _profileRepository;

  CreateUserProfileUseCase({required UserProfileRepository profileRepository})
      : _profileRepository = profileRepository;

  @override
  Future<Either<Failure, UserProfile>> call(
      CreateUserProfileUseCaseParams params) async {
    return await _profileRepository.createUserProfile(
      fullName: params.fullName,
      userName: params.userName,
      dob: params.dob,
      phoneNumber: params.phoneNumber,
      occupation: params.occupation,
      about: params.about,
      profilePic: params.profilePic,
      location: params.location,
      latitude: params.latitude,
      longitude: params.longitude,
      interests: params.interests,
    );
  }
}

class CreateUserProfileUseCaseParams {
  String fullName;
  String userName;
  String dob;
  int? phoneNumber;
  String? occupation;
  String? about;
  File? profilePic;
  String? location;
  double? latitude;
  double? longitude;
  List<String>? interests;

  CreateUserProfileUseCaseParams({
    required this.fullName,
    required this.userName,
    required this.dob,
    required this.phoneNumber,
    required this.occupation,
    required this.about,
    required this.profilePic,
    required this.location,
    required this.latitude,
    required this.interests,
    required this.longitude,
  });
}
