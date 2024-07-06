import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:fpdart/src/either.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/profile/domain/repository/profile_repository.dart';

class AddInterestUseCase implements UseCase<Unit, AddInterestUseCaseParams> {
  final UserProfileRepository _profileRepository;

  AddInterestUseCase({required UserProfileRepository profileRepository})
      : _profileRepository = profileRepository;

  @override
  Future<Either<Failure, Unit>> call(AddInterestUseCaseParams params) async {
    return await _profileRepository.addInterest(params.interests, params.uid);
  }
}

class AddInterestUseCaseParams {
  final List<String> interests;
  final String uid;

  AddInterestUseCaseParams({
    required this.interests,
    required this.uid,
  });
}
