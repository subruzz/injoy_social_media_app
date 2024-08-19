import 'package:cloud_firestore/cloud_firestore.dart';

class SingleStatusEntity {
  final String statusId;
  final String? content;
  final Timestamp createdAt;
  final int? color;
  final String? statusImage;
  final Map<String, Timestamp> viewers;
  final String uId;
  final bool isThatVdo;

  SingleStatusEntity({
    this.content,
    required this.uId,
    this.isThatVdo = false,
    required this.statusId,
    required this.createdAt,
    this.color,
    this.statusImage,
    required this.viewers,
  });

  factory SingleStatusEntity.fromJson(Map<String, dynamic> json) {
    // Safely convert viewers to a map of Strings to Timestamps
    Map<String, Timestamp> viewers = {};
    if (json['viewers'] != null) {
      final viewersData = json['viewers'] as Map<String, dynamic>;
      viewers = viewersData.map(
        (key, value) => MapEntry(
            key,
            value is Timestamp
                ? value
                : Timestamp.fromMillisecondsSinceEpoch(0)),
      );
    }

    return SingleStatusEntity(
      isThatVdo: json['isThatVdo'] ?? false,
      uId: json['uId'] ?? '',
      statusId: json['statusId'] ?? '',
      content: json['content'] as String?,
      createdAt: json['createdAt'] as Timestamp? ?? Timestamp.now(),
      color: json['color'] as int?,
      statusImage: json['statusImage'] as String?,
      viewers: viewers,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isThatVdo': isThatVdo,
      'uId': uId,
      'statusId': statusId,
      'content': content,
      'createdAt': createdAt,
      'color': color,
      'statusImage': statusImage,
      'viewers': viewers.map((key, value) => MapEntry(key, value)),
    };
  }
}
