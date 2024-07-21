// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/utils.dart';
import 'package:social_media_app/features/post/domain/repositories/post_repository.dart';

class CreatePostsUseCase implements UseCase<Unit, CreatePostsUseCaseParams> {
  final PostRepository _postRepository;

  CreatePostsUseCase({required PostRepository postRepository})
      : _postRepository = postRepository;
  @override
  Future<Either<Failure, Unit>> call(params) async {
    return await _postRepository.createPost(params.post, params.image);
  }
}

class CreatePostsUseCaseParams {
  final PostEntity post;
  final List<SelectedByte> image;
  CreatePostsUseCaseParams({
    required this.post,
    required this.image,
  });
}
