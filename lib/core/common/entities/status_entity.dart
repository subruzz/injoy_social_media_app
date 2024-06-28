import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/features/create_status/domain/entities/single_status_entity.dart';

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

  // Map<String, dynamic> toMap() {
  //   return {
  //     'uId': uId,
  //     'userName': userName,
  //     'profilePic': profilePic,
  //     'lastCreated': lastCreated,
  //     'statuses': statuses.map((status) => status.toJson()).toList(),
  //   };
  // }

  // static StatusEntity fromMap(Map<String, dynamic> map) {
  //   var statusesList = map['statuses'] as List<dynamic>;
  //   List<SingleStatusEntity> parsedStatuses =
  //       statusesList.map((status) => SingleStatusEntity.fromJson(status)).toList();
  //   return StatusEntity(
  //     uId: map['uId'],
  //     userName: map['userName'],
  //     profilePic: map['profilePic'],
  //     lastCreated: map['lastCreated'],
  //     statuses: parsedStatuses,
  //   );
  // }
}
