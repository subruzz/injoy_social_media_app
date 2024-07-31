import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/explore/domain/repositories/explore_app_repository.dart';

class GetNearybyUsersUseCase
    implements UseCase<List<PartialUser>, GetNearybyUsersUseCaseParams> {
  final ExploreAppRepository _exploreAppRepository;

  GetNearybyUsersUseCase({required ExploreAppRepository exploreAppRepository})
      : _exploreAppRepository = exploreAppRepository;

  @override
  Future<Either<Failure, List<PartialUser>>> call(
      GetNearybyUsersUseCaseParams params) async {
    return await _exploreAppRepository.getSuggestedOrNearbyUsers(
        params.interests,
        params.following,
        params.latitude,
        params.longitude,
        params.myId);
  }
}

class GetNearybyUsersUseCaseParams {
  final String myId;
  final double latitude;
  final double longitude;
  final List<String> interests;
  final List<String> following;
  GetNearybyUsersUseCaseParams(
      {required this.myId,
      required this.latitude,
      required this.following,
      required this.longitude,
      required this.interests});
}
