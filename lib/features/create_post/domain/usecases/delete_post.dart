// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:fpdart/fpdart.dart';
import 'package:fpdart/src/either.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/usecases/usecase.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/features/create_post/domain/repositories/post_repository.dart';

class DeletePostsUseCase implements UseCase<Unit, DeletePostsUseCaseParams> {
  final PostRepository _postRepository;

  DeletePostsUseCase({required PostRepository postRepository})
      : _postRepository = postRepository;
  @override
  Future<Either<Failure, Unit>> call(params) async {
    return await _postRepository.deletePost(params.post);
  }
}

class DeletePostsUseCaseParams {
  final PostEntity post;
  DeletePostsUseCaseParams({required this.post});
}
