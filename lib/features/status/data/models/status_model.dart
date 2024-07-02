import 'package:social_media_app/core/common/entities/status_entity.dart';
import 'package:social_media_app/core/common/entities/single_status_entity.dart';

class StatusModel extends StatusEntity {
  StatusModel({
    required super.uId,
    required super.userName,
    super.profilePic,
    required super.lastCreated,
    required super.statuses,
  });
  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'userName': userName,
      'profilePic': profilePic,
      'lastCreated': lastCreated,
      'statuses': statuses.map((status) => status.toJson()).toList(),
    };
  }

  static StatusModel fromMap(Map<String, dynamic> map) {
    var statusesList = map['statuses'] as List<dynamic>;
    List<SingleStatusEntity> parsedStatuses = statusesList
        .map((status) => SingleStatusEntity.fromJson(status))
        .toList();
    return StatusModel(
      uId: map['uId'],
      userName: map['userName'],
      profilePic: map['profilePic'],
      lastCreated: map['lastCreated'],
      statuses: parsedStatuses,
    );
  }
}
