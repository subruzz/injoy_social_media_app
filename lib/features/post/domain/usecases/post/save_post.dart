// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/post/domain/repositories/post_repository.dart';

class SavePostUseCase implements UseCase<Unit, SavePostUseCaseParams> {
  final PostRepository _postRepository;

  SavePostUseCase({required PostRepository postRepository})
      : _postRepository = postRepository;
  @override
  Future<Either<Failure, Unit>> call(params) async {
    return await _postRepository.savePosts(
      params.postId,
    );
  }
}

class SavePostUseCaseParams {
  final String postId;

  SavePostUseCaseParams({
    required this.postId,
  });
}
