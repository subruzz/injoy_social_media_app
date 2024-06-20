// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class StatusEntity {
  final String sId;
  final String userId;
  final String userName;
  final String? content;
  final Timestamp timestamp;
  final int color;
  final String? statusImage;
  StatusEntity({
    required this.sId,
    required this.userId,
    required this.userName,
    this.content,
    required this.timestamp,
    required this.color,
    this.statusImage,
  });
}
