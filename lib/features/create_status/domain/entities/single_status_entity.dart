// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class SingleStatusEntity {
  final String? content;
  final Timestamp timestamp;
  final int color;
  final String? statusImage;
  final List<String> viewers;

  SingleStatusEntity({
    this.content,
    required this.timestamp,
    required this.color,
    this.statusImage,
    required this.viewers,
  });

  factory SingleStatusEntity.fromJson(Map<String, dynamic> json) {
    List<String> viewers = [];
    if (json['viewers'] != null) {
      viewers = List<String>.from(json['viewers']);
    }
    return SingleStatusEntity(
      content: json['content'],
      timestamp: json['timestamp'] as Timestamp,
      color: json['color'] as int,
      statusImage: json['statusImage'],
      viewers: viewers,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'timestamp': timestamp,
      'color': color,
      'statusImage': statusImage,
      'viewers': viewers,
    };
  }
}
