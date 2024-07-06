// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:fpdart/fpdart.dart';
import 'package:fpdart/src/either.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/features/post/domain/repositories/post_repository.dart';

class GetAllPostsUseCase
    implements UseCase<List<PostEntity>, GetAllPostsUseCaseParams> {
  final PostRepository _postRepository;

  GetAllPostsUseCase({required PostRepository postRepository})
      : _postRepository = postRepository;
  @override
  Future<Either<Failure, List<PostEntity>>> call(params) async {
    return await _postRepository.getAllPosts(params.uid);
  }
}

class GetAllPostsUseCaseParams {
  final String uid;
  GetAllPostsUseCaseParams({required this.uid});
}
