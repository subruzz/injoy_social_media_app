import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String postId;
  final String creatorUid;
  final String username;
  final String userFullName;
  final List<String> postImageUrl;
  final List<String> likes;
  final bool isCommentOff;
  final String? description;
  final int likesCount;
  num totalComments;
  final Timestamp createAt;
  final bool isThatvdo;
  final bool isEdited;
  final String? userProfileUrl;
  final List<String> hashtags;
  final double? latitude;
  final double? longitude;
  final String? location;
  final String? extra;

  PostEntity({
    required this.postId,
    this.isThatvdo = false,
    required this.isEdited,
    required this.likesCount,
    this.extra,
    required this.isCommentOff,
    required this.creatorUid,
    required this.userFullName,
    this.latitude,
    this.location,
    this.longitude,
    required this.username,
    this.description,
    required this.postImageUrl,
    required this.likes,
    required this.totalComments,
    required this.createAt,
    this.userProfileUrl,
    required this.hashtags,
  });

  @override
  List<Object?> get props => [
        postId,
        creatorUid,
        username,
        description,
        postImageUrl,
        likes,
        totalComments,
        isThatvdo,
        createAt,
        userProfileUrl,
        hashtags,
        latitude,
        location,
        longitude,
        isCommentOff,
        isEdited,
      ];

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'creatorUid': creatorUid,
      'username': username,
      'userFullName': userFullName,
      'postImageUrl': postImageUrl,
      'likes': likes,
      'isCommentOff': isCommentOff,
      'description': description,
      'likesCount': likesCount,
      'totalComments': totalComments,
      'createAt': createAt,
      'isThatvdo': isThatvdo,
      'isEdited': isEdited,
      'userProfileUrl': userProfileUrl,
      'hashtags': hashtags,
      'latitude': latitude,
      'longitude': longitude,
      'location': location,
      'extra': extra,
    };
  }
}
