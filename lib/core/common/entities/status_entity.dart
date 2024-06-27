// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:social_media_app/features/create_status/domain/entities/single_status_entity.dart';

class StatusEntity {
  final String sId;
  final String uId;
  final String userName;
  final String? profilePic;
  final Timestamp lastCreated;
  List<SingleStatusEntity> statuses;
  StatusEntity({
    required this.sId,
    required this.uId,
    required this.userName,
    this.profilePic,
    required this.lastCreated,
    required this.statuses,
  });

 
}
