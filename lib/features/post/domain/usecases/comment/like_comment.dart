// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/post/domain/repositories/comment_repository.dart';

class LikeCommentUseCase implements UseCase<Unit, LikeCommentUseCaseParams> {
  final CommentRepository _commentRepository;

  LikeCommentUseCase({required CommentRepository commentRepository})
      : _commentRepository = commentRepository;
  @override
  Future<Either<Failure, Unit>> call(params) async {
    return await _commentRepository.likeComment(
      params.postId,
      params.commentId,
      params.currentUserId,
      params.isReel,
    );
  }
}

class LikeCommentUseCaseParams {
  final String currentUserId;
  final String postId;
  final String commentId;
  final bool isReel;

  LikeCommentUseCaseParams(
      {required this.currentUserId,
      required this.postId,
      required this.commentId,
      required this.isReel});
}
