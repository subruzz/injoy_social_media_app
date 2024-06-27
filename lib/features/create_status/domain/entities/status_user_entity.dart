import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/common/entities/status_entity.dart';

class StatusUserAttribute {
  final String uid;
  final String username;
  final String? profilePictureUrl;
  final Timestamp lastCreated;
  // final List<StatusEntity> statuses;

  StatusUserAttribute({
    required this.uid,
    required this.username,
    required this.profilePictureUrl,
    required this.lastCreated,
    // required this.statuses,
  });


  factory StatusUserAttribute.fromJson(
      Map<String, dynamic> json,) {
    return StatusUserAttribute(
      uid: json['uid'],
      username: json['username'],
      profilePictureUrl: json['profilePictureUrl'],
      lastCreated: json['lastCreated'],
      // statuses: statuses,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'username': username,
      'profilePictureUrl': profilePictureUrl,
      'lastCreated': lastCreated,
      // 'statuses': statuses.map((status) => status.toJson()).toList(),
    };
  }
}
