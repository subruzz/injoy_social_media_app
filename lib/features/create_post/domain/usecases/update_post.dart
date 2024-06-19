// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:fpdart/src/either.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/usecases/usecase.dart';
import 'package:social_media_app/features/create_post/domain/enitities/post.dart';
import 'package:social_media_app/features/create_post/domain/repositories/post_repository.dart';

class UpdatePostsUseCase implements UseCase<Unit, UpdatePostsUseCaseParams> {
  final PostRepository _postRepository;

  UpdatePostsUseCase({required PostRepository postRepository})
      : _postRepository = postRepository;
  @override
  Future<Either<Failure, Unit>> call(params) async {
    return await _postRepository.updatePost(params.post,params.postImagesUrls);
  }
}

class UpdatePostsUseCaseParams {
  final PostEntity post;
  final List<File?> postImagesUrls;
  UpdatePostsUseCaseParams({required this.post,required this.postImagesUrls});
}
