// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/post/domain/repositories/comment_repository.dart';

class UpdateCommentUseCase
    implements UseCase<Unit, UpdateCommentUseCaseParams> {
  final CommentRepository _commentRepository;

  UpdateCommentUseCase({required CommentRepository commentRepository})
      : _commentRepository = commentRepository;
  @override
  Future<Either<Failure, Unit>> call(params) async {
    return await _commentRepository.updateComment(
        params.postId, params.commentId, params.comment, params.isReel);
  }
}

class UpdateCommentUseCaseParams {
  final String postId;
  final String commentId;
  final String comment;
  final bool isReel;

  UpdateCommentUseCaseParams(
      {required this.postId,
      required this.commentId,
      required this.comment,
      required this.isReel});
}
