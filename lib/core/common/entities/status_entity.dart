import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/common/entities/single_status_entity.dart';

class StatusEntity {
  final String uId;
  final String userName;
  final String? profilePic;
  final Timestamp lastCreated;
  final List<SingleStatusEntity> statuses;

  StatusEntity({
    required this.uId,
    required this.userName,
    this.profilePic,
    required this.lastCreated,
    required this.statuses,
  });

  
}
