import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/status_entity.dart';
import 'package:social_media_app/core/common/entities/single_status_entity.dart';

import '../../../../core/common/models/partial_user_model.dart';
import '../../../../core/utils/errors/failure.dart';

abstract interface class StatusFeedRepository {
  Stream<List<StatusEntity>> getStatuses(String uId);
  Stream<List<SingleStatusEntity>> getMyStatus(String uid);
  Future<Either<Failure, List<(PartialUser, Timestamp)>>> getStatuseViewers(
      Map<String, Timestamp> viewersId);
}
