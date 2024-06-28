import 'package:social_media_app/core/common/entities/status_entity.dart';
import 'package:social_media_app/features/create_status/domain/entities/single_status_entity.dart';

class AllStatusEntity {
  final StatusEntity statusEntity;
  final List<SingleStatusEntity> allStatuses;

  AllStatusEntity({required this.statusEntity, required this.allStatuses});
}
