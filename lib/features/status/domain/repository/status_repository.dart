
import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/status_entity.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/core/common/entities/single_status_entity.dart';
import 'package:social_media_app/core/services/assets/asset_model.dart';

abstract interface class StatusRepository {
  Future<Either<Failure, Unit>> createStatus(SingleStatusEntity singleStatus);
  Future<Either<Failure, Unit>> createMultipleStatus(
          List<SingleStatusEntity> statuses, List<SelectedByte> assets);
  Future<Either<Failure, Unit>> seenStatusUpdate(
      String statusId, String viewedUserId);
  Future<Either<Failure, Unit>> deleteStatus(String statusId, String? imgUrl);

}
