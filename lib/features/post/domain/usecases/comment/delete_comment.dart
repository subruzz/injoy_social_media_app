// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/post/domain/repositories/comment_repository.dart';

class DeleteCommentUseCase
    implements UseCase<Unit, DeleteCommentUseCaseParams> {
  final CommentRepository _commentRepository;

  DeleteCommentUseCase({required CommentRepository commentRepository})
      : _commentRepository = commentRepository;
  @override
  Future<Either<Failure, Unit>> call(params) async {
    return await _commentRepository.deleteComment(
      params.postId,params.commentId
    );
  }
}

class DeleteCommentUseCaseParams {
  final String postId;
  final String commentId;

  DeleteCommentUseCaseParams({required this.postId, required this.commentId});
}
