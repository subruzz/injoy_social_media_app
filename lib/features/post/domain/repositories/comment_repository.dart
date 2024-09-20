import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/features/post/domain/enitities/comment_entity.dart';

abstract interface class CommentRepository {
  Future<Either<Failure, Unit>> createComment(CommentEntity comment, bool isReel);
  Stream<Either<Failure, List<CommentEntity>>> readComments(String postId, bool isReel);

  Future<Either<Failure, Unit>> updateComment(
      String postId, String commentId, String comment, bool isReel);

  Future<Either<Failure, Unit>> deleteComment(String postId, String commentId, bool isReel);

  Future<Either<Failure, Unit>> likeComment(
      String postId, String commentId, String currentUserId, bool isReel);
  Future<Either<Failure, Unit>> removeLikeComment(
      String postId, String commentId, String currentUserId, bool isReel);
}
