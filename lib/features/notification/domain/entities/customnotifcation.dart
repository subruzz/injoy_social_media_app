// ignore: must_be_immutable
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

enum NotificationType {
  post,
  profile,
  chat;

  String toJson() => name;
  static NotificationType fromJson(String json) {
    log('myr value $json');
    return values.byName(json);
  }
}

class NotificationCheck extends Equatable {
  String receiverId;
  String senderId;
  bool isThatPost;
  bool isThatLike;
  final String uniqueId;
  final String postId;
  final NotificationType notificationType;

  NotificationCheck({
    required this.receiverId,
    required this.senderId,
    required this.uniqueId,
    this.postId = '',
    this.isThatLike = true,
    this.isThatPost = true,
    required this.notificationType,
  });

  @override
  List<Object?> get props => [
        receiverId,
        senderId,
      ];
}

class CustomNotification extends NotificationCheck {
  String notificationUid;
  String text;
  Timestamp time;
  String personalUserName;
  String? postImageUrl;
  String? personalProfileImageUrl;
  String? senderName;
  final String notificationId;

  CustomNotification({
    required this.text,
    required super.senderId,
    required super.uniqueId,
    required this.time,
    required super.notificationType,
    required super.receiverId,
    this.postImageUrl,
    super.isThatPost,
    super.isThatLike,
    super.postId,
    required this.notificationId,
    required this.personalUserName,
    this.notificationUid = "",
    this.personalProfileImageUrl,
    this.senderName,
  });

  factory CustomNotification.fromJson(Map<String, dynamic> json) {
    log(NotificationType.fromJson(json['notificationType']).toString());
    return CustomNotification(
      text: json['text'] ?? '',
      time: json['time'] ?? Timestamp.now(),
      senderId: json['senderId'] ?? '',
      uniqueId: json['uniqueId'] ?? '',
      receiverId: json['receiverId'] ?? '',
      notificationId: json['notificationId'] ?? '',
      isThatLike: json['isThatLike'] ?? false,
      isThatPost: json['isThatPost'] ?? false,
      personalUserName: json['personalUserName'] ?? '',
      personalProfileImageUrl: json['personalProfileImageUrl'] ?? '',
      notificationType: NotificationType.fromJson(json['notificationType']),
      senderName: json['senderName'] ?? '',
      postId: json['postId'] ?? '',
      postImageUrl: json['postImageUrl'],
    );
  }

  Map<String, dynamic> toMap() => {
        "text": text,
        'notificationType': notificationType.toJson(),
        "time": FieldValue.serverTimestamp(),
        "receiverId": receiverId,
        "uniqueId": uniqueId,
        'postId': postId,
        "isThatLike": isThatLike,
        'notificationId': notificationId,
        "isThatPost": isThatPost,
        "senderId": senderId,
      };

  // Implementing copyWith method
  CustomNotification copyWith({
    String? notificationUid,
    String? text,
    Timestamp? time,
    String? personalUserName,
    String? postImageUrl,
    String? personalProfileImageUrl,
    String? senderName,
    String? notificationId,
    String? senderId,
    String? uniqueId,
    NotificationType? notificationType,
    String? receiverId,
    bool? isThatPost,
    bool? isThatLike,
    String? postId,
  }) {
    return CustomNotification(
      notificationUid: notificationUid ?? this.notificationUid,
      text: text ?? this.text,
      time: time ?? this.time,
      personalUserName: personalUserName ?? this.personalUserName,
      postImageUrl: postImageUrl ?? this.postImageUrl,
      personalProfileImageUrl: personalProfileImageUrl ?? this.personalProfileImageUrl,
      senderName: senderName ?? this.senderName,
      notificationId: notificationId ?? this.notificationId,
      senderId: senderId ?? this.senderId,
      uniqueId: uniqueId ?? this.uniqueId,
      notificationType: notificationType ?? this.notificationType,
      receiverId: receiverId ?? this.receiverId,
      isThatPost: isThatPost ?? this.isThatPost,
      isThatLike: isThatLike ?? this.isThatLike,
      postId: postId ?? this.postId,
    );
  }
}
