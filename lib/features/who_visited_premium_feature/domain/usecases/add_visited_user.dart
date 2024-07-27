import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/who_visited_premium_feature/domain/repositories/who_visited_repository.dart';

class AddVisitedUserUseCase
    implements UseCase<Unit, AddVisitedUserUseCaseParams> {
  final WhoVisitedRepository _whoVisitedRepository;

  AddVisitedUserUseCase({required WhoVisitedRepository whoVisitedRepository})
      : _whoVisitedRepository = whoVisitedRepository;

  @override
  Future<Either<Failure, Unit>> call(AddVisitedUserUseCaseParams params) async {
    return await _whoVisitedRepository.addTheVisitedUser(
        visitedUserId: params.visitedUserId, myId: params.myId);
  }
}

class AddVisitedUserUseCaseParams {
  final String myId;
  final String visitedUserId;

  AddVisitedUserUseCaseParams(
      {required this.myId, required this.visitedUserId});
}
