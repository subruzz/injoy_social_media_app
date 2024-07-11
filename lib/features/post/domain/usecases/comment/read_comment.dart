// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/post/domain/enitities/comment_entity.dart';
import 'package:social_media_app/features/post/domain/repositories/comment_repository.dart';

class ReadCommentUseCase {
  final CommentRepository _commentRepository;

  ReadCommentUseCase({required CommentRepository commentRepository})
      : _commentRepository = commentRepository;

  Stream<Either<Failure, List<CommentEntity>>> call(String postId) {
    return _commentRepository.readComments(postId);
  }
}
