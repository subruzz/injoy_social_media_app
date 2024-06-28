import 'package:cloud_firestore/cloud_firestore.dart';

class StatusEntity {
  final String uId;
  final String userName;
  final String? profilePic;
  final Timestamp lastCreated;

  StatusEntity({
    required this.uId,
    required this.userName,
    this.profilePic,
    required this.lastCreated,
  });

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'userName': userName,
      'profilePic': profilePic,
      'lastCreated': lastCreated,
    };
  }

  static StatusEntity fromMap(Map<String, dynamic> map) {
    return StatusEntity(
      uId: map['uId'],
      userName: map['userName'],
      profilePic: map['profilePic'],
      lastCreated: map['lastCreated'],
    );
  }
}
