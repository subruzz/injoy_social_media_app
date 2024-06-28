import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/status_entity.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/create_status/domain/entities/all_status_entity.dart';
import 'package:social_media_app/features/create_status/domain/entities/single_status_entity.dart';

abstract interface class StatusRepository {
  Future<Either<Failure, Unit>> createStatus(
      StatusEntity status, SingleStatusEntity singleStatus);
  Future<Either<Failure, Unit>> updateStatus(StatusEntity status);
  Future<Either<Failure, Unit>> updateOnlyImageStatus(StatusEntity status);
  Future<Either<Failure, Unit>> seenStatusUpdate(
      int index, String userId, String viewedUserId);
  Future<Either<Failure, Unit>> deleteStatus(String statusId, String uId);
  Stream<List<StatusEntity>> getStatuses(String uId);
  Stream<StatusEntity> getMyStatus(String uid);
  Future<Either<Failure, List<StatusEntity>>> getMyStatusFuture(String uid);
}
