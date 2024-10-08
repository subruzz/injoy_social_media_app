// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/post/domain/repositories/post_repository.dart';

import '../../../../../core/common/entities/post.dart';

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
