import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/post/domain/enitities/comment_entity.dart';

abstract interface class CommentRepository {
  Future<Either<Failure, Unit>> createComment(CommentEntity comment);
  Stream<Either<Failure, List<CommentEntity>>> readComments(String postId);

  Future<Either<Failure, Unit>> updateComment(
      String postId, String commentId, String comment);

  Future<Either<Failure, Unit>> deleteComment(String postId, String commentId);

  Future<Either<Failure, Unit>> likeComment(CommentEntity comment);
}
