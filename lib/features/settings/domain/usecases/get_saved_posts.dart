import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/settings/domain/repository/library_repostory.dart';

import '../../../../core/utils/errors/failure.dart';

class GetSavedPostsUseCase
    implements UseCase<List<PostEntity>, GetSavedPostsUseCaseParams> {
  final LibraryRepostory _libraryRepostory;

  GetSavedPostsUseCase({required LibraryRepostory libraryRepostory})
      : _libraryRepostory = libraryRepostory;

  @override
  Future<Either<Failure, List<PostEntity>>> call(params) async {
    return await _libraryRepostory.getSavedPosts(
        savedPostsId: params.savedPostIds);
  }
}

class GetSavedPostsUseCaseParams {
  final List<String> savedPostIds;

  GetSavedPostsUseCaseParams({required this.savedPostIds});
}
