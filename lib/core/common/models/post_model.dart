import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/common/entities/post.dart';

class PostModel extends PostEntity {
  const PostModel({
    required super.postId,
    required super.creatorUid,
    required super.username,
    super.description,
    required super.postImageUrl,
    required super.userFullName,
    required super.likes,
    super.totalComments,
    required super.createAt,
    super.userProfileUrl,
    required super.hashtags,
    super.latitude,
    super.location,
    super.longitude,
  });

  // 1. From JSON (Firestore)
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      userFullName: json['userFullName'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      location: json['location'],
      postId: json['postId'],
      creatorUid: json['creatorUid'],
      username: json['username'],
      description: json['description'],
      postImageUrl: List<String>.from(json['postImageUrl'] ?? []),
      likes: List<String>.from(json['likes'] ?? []),
      totalComments: json['totalComments'],
      createAt: json['createAt'],
      userProfileUrl: json['userProfileUrl'],
      hashtags: List<String>.from(json['hashtags'] ?? []),
    );
  }

  // 2. To JSON (Firestore)
  Map<String, dynamic> toJson() {
    return {
      'userFullName': userFullName,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'postId': postId,
      'creatorUid': creatorUid,
      'username': username,
      'description': description,
      'postImageUrl': postImageUrl,
      'likes': likes,
      'totalComments': totalComments,
      'createAt': createAt,
      'userProfileUrl': userProfileUrl,
      'hashtags': hashtags,
    };
  }

  // 3. CopyWith (for immutability)
  PostModel copyWith(
      {String? postId,
      String? creatorUid,
      String? username,
      String? description,
      List<String>? postImageUrl,
      List<String>? likes,
      num? totalComments,
      Timestamp? createAt,
      String? userProfileUrl,
      List<String>? hashtags,
      String? userFullName}) {
    return PostModel(
      userFullName: userFullName ?? this.userFullName,
      postId: postId ?? this.postId,
      creatorUid: creatorUid ?? this.creatorUid,
      username: username ?? this.username,
      description: description ?? this.description,
      postImageUrl: postImageUrl ?? this.postImageUrl,
      likes: likes ?? this.likes,
      totalComments: totalComments ?? this.totalComments,
      createAt: createAt ?? this.createAt,
      userProfileUrl: userProfileUrl ?? this.userProfileUrl,
      hashtags: hashtags ?? this.hashtags,
    );
  }
}
