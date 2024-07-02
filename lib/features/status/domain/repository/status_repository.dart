import 'package:fpdart/fpdart.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/core/common/entities/status_entity.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/entities/single_status_entity.dart';

abstract interface class StatusRepository {
  Future<Either<Failure, Unit>> createStatus(SingleStatusEntity singleStatus);
  Future<Either<Failure, Unit>> createMultipleStatus(
      StatusEntity status, List<String> caption, List<AssetEntity> assets);
  Future<Either<Failure, Unit>> seenStatusUpdate(
      String statusId, String viewedUserId);
  Future<Either<Failure, Unit>> deleteStatus(String statusId, String? imgUrl);

}
