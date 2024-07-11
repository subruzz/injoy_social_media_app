import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media_app/core/const/fireabase_const/firebase_collection.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/features/post/data/models/comment_model.dart';
import 'package:social_media_app/features/post/domain/enitities/comment_entity.dart';

abstract interface class CommentRemoteDatasource {
  Future<void> createComment(CommentModel comment);
  Stream<List<CommentEntity>> readComments(String postId);
  Future<void> updateComment(String postId, String commentId, String comment);
  Future<void> deleteComment(String postId, String commentId);
  Future<void> likeComment(
      String postId, String commentId, String currentUserId);
  Future<void> removeLikeComment(
      String postId, String commentId, String currentUserId);
}

class CommentRemoteDatasourceImpl implements CommentRemoteDatasource {
  final FirebaseFirestore _firebaseFirestore;

  CommentRemoteDatasourceImpl({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;
  @override
  Future<void> createComment(CommentModel comment) async {
    final commentCollection = _firebaseFirestore
        .collection(FirebaseCollectionConst.posts)
        .doc(comment.postId)
        .collection(FirebaseCollectionConst.comments);

    try {
      final commentDocRef =
          await commentCollection.doc(comment.commentId).get();
      if (!commentDocRef.exists) {
        commentCollection
            .doc(comment.commentId)
            .set(comment.toJson())
            .then((value) {
          final postCollection = _firebaseFirestore
              .collection(FirebaseCollectionConst.posts)
              .doc(comment.postId);
          postCollection.get().then((value) {
            if (value.exists) {
              final totalComments = value.get('totalComments');
              postCollection.update({'totalComments': totalComments + 1});
              return;
            }
          });
        });
      } else {
        commentCollection.doc(comment.commentId).update(comment.toJson());
      }
    } catch (e) {
      throw const MainException();
    }
  }

  @override
  Future<void> deleteComment(String postId, String commentId) async {
    final commentCollection = _firebaseFirestore
        .collection(FirebaseCollectionConst.posts)
        .doc(postId)
        .collection(FirebaseCollectionConst.comments);

    try {
      await commentCollection.doc(commentId).delete().then((value) {
        final postCollection = _firebaseFirestore
            .collection(FirebaseCollectionConst.posts)
            .doc(postId);
        postCollection.get().then((value) {
          if (value.exists) {
            final totalComments = value.get('totalComments');
            postCollection.update({'totalComments': totalComments - 1});
            return;
          }
        });
      });
    } catch (e) {
      throw const MainException();
    }
  }

  @override
  Stream<List<CommentEntity>> readComments(String postId) {
    final commentCollection = _firebaseFirestore
        .collection(FirebaseCollectionConst.posts)
        .doc(postId)
        .collection(FirebaseCollectionConst.comments)
        .orderBy('createdAt', descending: true);
    return commentCollection.snapshots().map((snap) {
      log('listening for comment change');
      return snap.docs.map((e) => CommentModel.fromJson(e.data())).toList();
    });
  }

  @override
  Future<void> updateComment(
      String postId, String commentId, String comment) async {
    final commentCollection = _firebaseFirestore
        .collection(FirebaseCollectionConst.posts)
        .doc(postId)
        .collection(FirebaseCollectionConst.comments);
    try {
      commentCollection
          .doc(commentId)
          .update({'comment': comment, 'isEdited': true});
    } catch (e) {
      throw const MainException();
    }
  }

  @override
  Future<void> removeLikeComment(
      String postId, String commentId, String currentUserId) async {
    try {
      final commentCollection = _firebaseFirestore
          .collection(FirebaseCollectionConst.posts)
          .doc(postId)
          .collection(FirebaseCollectionConst.comments);
      await commentCollection.doc(commentId).update({
        'likes': FieldValue.arrayRemove([currentUserId])
      });
    } catch (e) {
      log('removecomment like error');
      throw const MainException();
    }
  }

  @override
  Future<void> likeComment(
      String postId, String commentId, String currentUserId) async {
    try {
      final commentCollection = _firebaseFirestore
          .collection(FirebaseCollectionConst.posts)
          .doc(postId)
          .collection(FirebaseCollectionConst.comments);
      await commentCollection.doc(commentId).update({
        'likes': FieldValue.arrayUnion([currentUserId])
      });
    } catch (e) {
      throw const MainException();
    }
  }
}

// @override
// Future<void> likeComment(CommentEntity comment, String currentUserId) async {
//   final commentCollection = _firebaseFirestore
//       .collection(FirebaseCollectionConst.posts)
//       .doc(comment.postId)
//       .collection(FirebaseCollectionConst.comments);
//   try {
//     final commentDocRef = await commentCollection.doc(comment.commentId).get();

//     if (commentDocRef.exists) {
//       List likes = commentDocRef.get('likes');
//       if (likes.contains(currentUserId)) {
//         commentCollection.doc(comment.commentId).update({
//           'likes': FieldValue.arrayRemove([currentUserId])
//         });
//       } else {
//         commentCollection.doc(comment.commentId).update({
//           'likes': FieldValue.arrayUnion([currentUserId])
//         });
//       }
//     }
//   } catch (e) {
//     throw const MainException();
//   }
// }
