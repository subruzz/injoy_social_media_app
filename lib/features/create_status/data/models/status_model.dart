import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/common/entities/status_entity.dart';

class StatusModel extends StatusEntity {
  StatusModel({
    required super.sId,
    required super.userId,
    super.content,
    super.statusImage,
    required super.timestamp,
    required super.color,
    required super.userName,
  });

  factory StatusModel.fromMap(Map<String, dynamic> data) {
    return StatusModel(
        userName: data['userName'],
        sId: data['sId'],
        userId: data['userId'] ?? '',
        content: data['content'] ?? '',
        timestamp: (data['timestamp'] as Timestamp),
        color: data['color'] ?? 0,
        statusImage: data['statusImage']);
  }

  Map<String, dynamic> toMap() {
    return {
      'sId': sId,
      'userName': userName,
      'statusImage': statusImage,
      'userId': userId,
      'content': content,
      'timestamp': timestamp,
      'color': color,
    };
  }
}
