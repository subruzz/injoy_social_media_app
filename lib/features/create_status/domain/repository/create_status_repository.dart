import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/status_entity.dart';
import 'package:social_media_app/core/errors/failure.dart';

abstract interface class StatusRepository {
  Future<Either<Failure, Unit>> createStatus(StatusEntity status);
  Future<Either<Failure, Unit>> updateStatus(StatusEntity status);
  Future<Either<Failure, Unit>> updateOnlyImageStatus(StatusEntity status);
  Future<Either<Failure, Unit>> seenStatusUpdate(
      String statusId, int imageIndex, String userId);
  Future<Either<Failure, Unit>> deleteStatus(StatusEntity status);
  Stream<Either<Failure, List<StatusEntity>>> getStatuses(StatusEntity status);
  Stream<Either<Failure, List<StatusEntity>>> getMyStatus(String uid);
  Future<Either<Failure, List<StatusEntity>>> getMyStatusFuture(String uid);
}
