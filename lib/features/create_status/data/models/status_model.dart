import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/common/entities/status_entity.dart';

class StatusModel extends StatusEntity {
  StatusModel({
    required super.uId,
    required super.userName,
    super.profilePic,
    required super.lastCreated,
  });

  factory StatusModel.fromJson(Map<String, dynamic> json) {
  
    return StatusModel(
      uId: json['uId'],
      userName: json['userName'],
      profilePic: json['profilePic'],
      lastCreated: json['lastCreated'] as Timestamp,
    );
  }

  Map<String, dynamic> toJson() {


    return {
      'uId': uId,
      'userName': userName,
      'profilePic': profilePic,
      'lastCreated': lastCreated,
    };
  }
}
