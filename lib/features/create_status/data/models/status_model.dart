import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/common/entities/status_entity.dart';
import 'package:social_media_app/features/create_status/domain/entities/single_status_entity.dart';

class StatusModel extends StatusEntity {
  StatusModel({
    required super.sId,
    required super.uId,
    required super.userName,
    super.profilePic,
    required super.lastCreated,
    required super.statuses,
  });

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    var statusList = <SingleStatusEntity>[];
    if (json['statuses'] != null) {
      var list = json['statuses'] as List;
      statusList = list.map((e) => SingleStatusEntity.fromJson(e)).toList();
    }
    return StatusModel(
      sId: json['sId'],
      uId: json['uId'],
      userName: json['userName'],
      profilePic: json['profilePic'],
      lastCreated: json['lastCreated'] as Timestamp,
      statuses: statusList,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> statusJsonList =
        statuses.map((status) => status.toJson()).toList();

    return {
      'sId': sId,
      'uId': uId,
      'userName': userName,
      'profilePic': profilePic,
      'lastCreated': lastCreated,
      'statuses': statusJsonList,
    };
  }
}
