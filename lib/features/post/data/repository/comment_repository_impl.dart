import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/post/data/datasources/remote/comment_remote_datasource.dart';
import 'package:social_media_app/features/post/data/models/comment_model.dart';
import 'package:social_media_app/features/post/domain/enitities/comment_entity.dart';
import 'package:social_media_app/features/post/domain/repositories/comment_repository.dart';

class CommentRepositoryImpl implements CommentRepository {
  final CommentRemoteDatasource _commentRemoteDatasource;

  CommentRepositoryImpl(
      {required CommentRemoteDatasource commentRemoteDatasource})
      : _commentRemoteDatasource = commentRemoteDatasource;
  @override
  Future<Either<Failure, Unit>> createComment(CommentEntity comment) async {
    try {
      await _commentRemoteDatasource
          .createComment(CommentModel.fromEntity(comment));
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateComment(
      String postId, String commentId, String comment) async {
    try {
      await _commentRemoteDatasource.updateComment(postId, commentId, comment);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteComment(
      String postId, String commentId) async {
    try {
      await _commentRemoteDatasource.deleteComment(postId, commentId);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }

  @override
  Future<Either<Failure, Unit>> likeComment(CommentEntity comment) {
    // TODO: implement likeComment
    throw UnimplementedError();
  }

  @override
  Stream<Either<Failure, List<CommentEntity>>> readComments(String postId) {
    // TODO: implement readComments
    throw UnimplementedError();
  }
}
