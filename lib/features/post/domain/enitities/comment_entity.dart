import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String comment;
  final String userName;
  final String? userProfile;
  final Timestamp createdAt;
  final List<String> likes;
  final int totalReplies;
  final String commentId;
  final String postId;
  final String creatorId;
  final bool isEdited;

  const CommentEntity(
      {required this.comment,
      required this.isEdited,
      required this.creatorId,
      required this.userName,
      required this.postId,
      required this.commentId,
      required this.totalReplies,
      required this.userProfile,
      required this.createdAt,
      required this.likes});
  @override
  List<Object?> get props => [
        comment,
        userName,
        userProfile,
        createdAt,
        likes,
        totalReplies,
        commentId,
        postId,
        creatorId,
        isEdited
      ];
}
