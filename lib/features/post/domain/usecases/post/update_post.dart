// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:fpdart/fpdart.dart';
import 'package:fpdart/src/either.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/post/domain/enitities/update_post.dart';
import 'package:social_media_app/features/post/domain/repositories/post_repository.dart';

class UpdatePostsUseCase
    implements UseCase<PostEntity, UpdatePostsUseCaseParams> {
  final PostRepository _postRepository;

  UpdatePostsUseCase({required PostRepository postRepository})
      : _postRepository = postRepository;
  @override
  Future<Either<Failure, PostEntity>> call(params) async {
    return await _postRepository.updatePost(
      params.post,
      params.postUser,
      params.postId,
    );
  }
}

class UpdatePostsUseCaseParams {
  final UpdatePostEntity post;
  final String postId;
  final PartialUser postUser;
  UpdatePostsUseCaseParams(
      {required this.post, required this.postId, required this.postUser});
}
