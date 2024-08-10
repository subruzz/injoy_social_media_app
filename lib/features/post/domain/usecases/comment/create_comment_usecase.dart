// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/post/domain/enitities/comment_entity.dart';
import 'package:social_media_app/features/post/domain/repositories/comment_repository.dart';

class CreateCommentUsecase
    implements UseCase<Unit, CreateCommentUsecaseParams> {
  final CommentRepository _commentRepository;

  CreateCommentUsecase({required CommentRepository commentRepository})
      : _commentRepository = commentRepository;
  @override
  Future<Either<Failure, Unit>> call(params) async {
    return await _commentRepository.createComment(
      params.comment,params.isReel
    );
  }
}

class CreateCommentUsecaseParams {
  final CommentEntity comment;
  final bool isReel;

  CreateCommentUsecaseParams({required this.comment, required this.isReel});
 
}
