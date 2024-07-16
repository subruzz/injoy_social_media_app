import 'package:social_media_app/core/common/entities/post.dart';

class PostModel extends PostEntity {
   PostModel({
    required super.postId,
    required super.creatorUid,
    required super.username,
    super.description,
    required super.likesCount,
    required super.postImageUrl,
    required super.userFullName,
    required super.likes,
    required super.totalComments,
    required super.createAt,
    super.userProfileUrl,
    required super.hashtags,
    super.latitude,
    super.location,
    super.longitude,
    required super.isCommentOff,
  });

  // 1. From JSON (Firestore)
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      likesCount: json['likesCount'],
      isCommentOff: json['isCommentOff'],
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
      'likesCount': likesCount,
      'isCommentOff': isCommentOff,
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
  // PostModel copyWith(
  //     {String? postId,
  //     String? creatorUid,
  //     String? username,
  //     String? description,
  //     List<String>? postImageUrl,
  //     List<String>? likes,
  //     num? totalComments,
  //     Timestamp? createAt,
  //     String? userProfileUrl,
  //     List<String>? hashtags,
  //     bool? isCommentoff,
  //     String? userFullName}) {
  //   return PostModel(
  //     isCommentOff: isCommentOff ?? this.isCommentOff,
  //     userFullName: userFullName ?? this.userFullName,
  //     postId: postId ?? this.postId,
  //     creatorUid: creatorUid ?? this.creatorUid,
  //     username: username ?? this.username,
  //     description: description ?? this.description,
  //     postImageUrl: postImageUrl ?? this.postImageUrl,
  //     likes: likes ?? this.likes,
  //     totalComments: totalComments ?? this.totalComments,
  //     createAt: createAt ?? this.createAt,
  //     userProfileUrl: userProfileUrl ?? this.userProfileUrl,
  //     hashtags: hashtags ?? this.hashtags,
  //   );
  // }
}
