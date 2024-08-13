import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';

class PostModel extends PostEntity {
  PostModel(
      {required super.postId,
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
      required super.isThatvdo,
      super.location,
      super.longitude,
      required super.isCommentOff,
      required super.isEdited,
      super.extra});

  // 1. From JSON (Firestore)
  factory PostModel.fromJson(
      Map<String, dynamic> json, PartialUser partialUser) {
    return PostModel(
      extra: json['extra'],
      isThatvdo: json['isThatvdo'] ?? false,
      isEdited: json['isEdited'],
      likesCount: json['likesCount'],
      isCommentOff: json['isCommentOff'],
      userFullName: partialUser.fullName ?? '',
      latitude: json['latitude'],
      longitude: json['longitude'],
      location: json['location'],
      postId: json['postId'],
      creatorUid: json['creatorUid'],
      username: partialUser.userName ?? '',
      description: json['description'],
      postImageUrl: List<String>.from(json['postImageUrl'] ?? []),
      likes: List<String>.from(json['likes'] ?? []),
      totalComments: json['totalComments'],
      createAt: json['createAt'],
      userProfileUrl: partialUser.profilePic,
      hashtags: List<String>.from(json['hashtags'] ?? []),
    );
  }

  // 2. To JSON (Firestore)
  Map<String, dynamic> toJson() {
    return {
      'isThatvdo': isThatvdo,
      'extra': extra,
      'isEdited': isEdited,
      'likesCount': likesCount,
      'isCommentOff': isCommentOff,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'postId': postId,
      'creatorUid': creatorUid,
      'description': description,
      'postImageUrl': postImageUrl,
      'likes': likes,
      'totalComments': totalComments,
      'createAt': createAt,
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
