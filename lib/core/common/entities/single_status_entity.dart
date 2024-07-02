

import 'package:cloud_firestore/cloud_firestore.dart';

class SingleStatusEntity {
  final String statusId;
  final String? content;
  final Timestamp createdAt;
  final int? color;
  final String? statusImage;
  final List<String> viewers;
  final String uId;
  SingleStatusEntity( {
    this.content,required this.uId,
    required this.statusId,
    required this.createdAt,
     this.color,
    this.statusImage,
    required this.viewers,
  });

  factory SingleStatusEntity.fromJson(Map<String, dynamic> json) {
    List<String> viewers = [];
    if (json['viewers'] != null) {
      viewers = List<String>.from(json['viewers']);
    }
    return SingleStatusEntity(
      uId:json['uId'],
      statusId: json['statusId'],
      content: json['content'],
      createdAt: json['createdAt'] as Timestamp,
      color: json['color'],
      statusImage: json['statusImage'],
      viewers: viewers,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uId':uId,
      'statusId': statusId,
      'content': content,
      'createdAt': createdAt,
      'color': color,
      'statusImage': statusImage,
      'viewers': viewers,
    };
  }
}
