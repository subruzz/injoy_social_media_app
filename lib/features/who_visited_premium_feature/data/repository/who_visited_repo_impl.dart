import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/utils/errors/exception.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/features/who_visited_premium_feature/data/datasource/who_visited_data_source.dart';
import 'package:social_media_app/features/who_visited_premium_feature/domain/entity/uservisit.dart';
import 'package:social_media_app/features/who_visited_premium_feature/domain/repositories/who_visited_repository.dart';

class WhoVisitedRepoImpl implements WhoVisitedRepository {
  final WhoVisitedDataSource _whoVisitedDataSource;

  WhoVisitedRepoImpl({required WhoVisitedDataSource whoVisitedDataSource})
      : _whoVisitedDataSource = whoVisitedDataSource;
  @override
  Future<Either<Failure, Unit>> addTheVisitedUser(
      {required String visitedUserId, required String myId}) async {
    try {
      await _whoVisitedDataSource.addTheVisitedUser(
          visitedUserId: visitedUserId, myId: myId);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }

  @override
  Future<Either<Failure, List<UserVisit>>> getProfileVisitedProfiles(
      {required String myId}) async {
    try {
      final res =
          await _whoVisitedDataSource.getProfileVisitedProfiles(myId: myId);
      return right(res);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }
}
