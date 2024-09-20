import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/who_visited_premium_feature/domain/entity/uservisit.dart';
import 'package:social_media_app/features/who_visited_premium_feature/domain/repositories/who_visited_repository.dart';

class GetAllVisitedUserUseCase
    implements UseCase<List<UserVisit>, GetAllVisitedUserUseCaseParams> {
  final WhoVisitedRepository _whoVisitedRepository;

  GetAllVisitedUserUseCase({required WhoVisitedRepository whoVisitedRepository})
      : _whoVisitedRepository = whoVisitedRepository;

  @override
  Future<Either<Failure, List<UserVisit>>> call(
      GetAllVisitedUserUseCaseParams params) async {
    return await _whoVisitedRepository.getProfileVisitedProfiles(
        myId: params.myId);
  }
}

class GetAllVisitedUserUseCaseParams {
  final String myId;

  GetAllVisitedUserUseCaseParams({
    required this.myId,
  });
}
