import 'package:social_media_app/core/common/entities/status_entity.dart';
import 'package:social_media_app/core/common/entities/single_status_entity.dart';

abstract interface class StatusFeedRepository {
  Stream<List<StatusEntity>> getStatuses(String uId);
  Stream<List<SingleStatusEntity>> getMyStatus(String uid);
}
