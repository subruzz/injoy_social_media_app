import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/features/who_visited_premium_feature/domain/entity/uservisit.dart';

abstract interface class WhoVisitedRepository {
  Future<Either<Failure, Unit>> addTheVisitedUser(
      {required String visitedUserId, required String myId});
  Future<Either<Failure, List<UserVisit>>> getProfileVisitedProfiles(
      {required String myId});
}
