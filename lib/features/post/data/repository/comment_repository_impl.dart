import 'dart:developer';
import 'dart:io';

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
  Stream<Either<Failure, List<CommentEntity>>> readComments(
      String postId) async* {
    try {
      await for (final comments
          in _commentRemoteDatasource.readComments(postId)) {
        log('we have ${comments.length}from repo impl');
        yield Right(comments);
      }
    } on SocketException catch (e) {
      yield Left(Failure(e.toString()));
    } catch (e) {
      yield Left(Failure());
    }
  }

  @override
  Future<Either<Failure, Unit>> likeComment(
      String postId, String commentId, String currentUserId) async {
    try {
      await _commentRemoteDatasource.likeComment(
          postId, commentId, currentUserId);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeLikeComment(
      String postId, String commentId, String currentUserId) async {
    try {
      await _commentRemoteDatasource.removeLikeComment(
          postId, commentId, currentUserId);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }
}
