import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/settings/domain/repository/library_repostory.dart';

import '../../../../core/utils/errors/failure.dart';

class GetLikedPostsUseCase
    implements UseCase<List<PostEntity>, GetLikedPostsUseCaseParams> {
  final LibraryRepostory _libraryRepostory;

  GetLikedPostsUseCase({required LibraryRepostory libraryRepostory})
      : _libraryRepostory = libraryRepostory;

  @override
  Future<Either<Failure, List<PostEntity>>> call(params) async {
    return await _libraryRepostory.getLikedPosts(myId: params.myId);
  }
}

class GetLikedPostsUseCaseParams {
  final String myId;

  GetLikedPostsUseCaseParams({required this.myId});
}
