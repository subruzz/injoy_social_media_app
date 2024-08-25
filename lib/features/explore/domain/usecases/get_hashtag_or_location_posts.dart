import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/explore/domain/repositories/explore_app_repository.dart';

class GetHashtagOrLocationPostsUseCase
    implements
        UseCase<List<PostEntity>, GetHashtagOrLocationPostsUseCaseParams> {
  final ExploreAppRepository _exploreAppRepository;

  GetHashtagOrLocationPostsUseCase(
      {required ExploreAppRepository exploreAppRepository})
      : _exploreAppRepository = exploreAppRepository;

  @override
  Future<Either<Failure, List<PostEntity>>> call(
      GetHashtagOrLocationPostsUseCaseParams params) async {
    return await _exploreAppRepository.getPostsOfHashTagsOrLocation(
        params.tagOrLocation, params.isLoc);
  }
}

class GetHashtagOrLocationPostsUseCaseParams {
  final String tagOrLocation;
  final bool isLoc;

  GetHashtagOrLocationPostsUseCaseParams(
      {required this.tagOrLocation, required this.isLoc});
}
