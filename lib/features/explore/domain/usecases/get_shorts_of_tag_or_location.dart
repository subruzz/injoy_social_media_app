import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/explore/domain/repositories/explore_app_repository.dart';

class GetShortsOfTagOrLocationUseCase
    implements
        UseCase<List<PostEntity>, GetShortsOfTagOrLocationUseCaseParams> {
  final ExploreAppRepository _exploreAppRepository;

  GetShortsOfTagOrLocationUseCase(
      {required ExploreAppRepository exploreAppRepository})
      : _exploreAppRepository = exploreAppRepository;

  @override
  Future<Either<Failure, List<PostEntity>>> call(
      GetShortsOfTagOrLocationUseCaseParams params) async {
    return await _exploreAppRepository.getShortsOfTagOrLocation(
        params.tagOrLocation, params.isLoc);
  }
}

class GetShortsOfTagOrLocationUseCaseParams {
  final String tagOrLocation;
  final bool isLoc;

  GetShortsOfTagOrLocationUseCaseParams(
      {required this.tagOrLocation, required this.isLoc});
}
