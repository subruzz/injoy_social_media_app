import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/features/post/domain/enitities/comment_entity.dart';

class CommentModel extends CommentEntity {
  const CommentModel({
    required super.comment,
    required super.creatorId,
    required super.userName,
    required super.postId,
    required super.commentId,
    required super.totalReplies,
    required super.userProfile,
    required super.createdAt,
    required super.likes,
    required super.isEdited,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      isEdited: json['isEdited'] as bool,
      comment: json['comment'] as String,
      creatorId: json['creatorId'] as String,
      userName: json['userName'] as String,
      postId: json['postId'] as String,
      commentId: json['commentId'] as String,
      totalReplies: json['totalReplies'] as int,
      userProfile: json['userProfile'] as String?,
      createdAt: json['createdAt'] as Timestamp,
      likes: List<String>.from(json['likes']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isEdited': isEdited,
      'comment': comment,
      'creatorId': creatorId,
      'userName': userName,
      'postId': postId,
      'commentId': commentId,
      'totalReplies': totalReplies,
      'userProfile': userProfile,
      'createdAt': createdAt,
      'likes': likes,
    };
  }

  static CommentModel fromEntity(CommentEntity entity) {
    return CommentModel(
      isEdited: entity.isEdited,
      comment: entity.comment,
      creatorId: entity.creatorId,
      userName: entity.userName,
      postId: entity.postId,
      commentId: entity.commentId,
      totalReplies: entity.totalReplies,
      userProfile: entity.userProfile,
      createdAt: entity.createdAt,
      likes: entity.likes,
    );
  }
}
