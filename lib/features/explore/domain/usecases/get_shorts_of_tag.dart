import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/explore/domain/repositories/explore_app_repository.dart';

class GetShortsOfTagUseCase
    implements UseCase<List<PostEntity>, GetShortsOfTagUseCaseParams> {
  final ExploreAppRepository _exploreAppRepository;

  GetShortsOfTagUseCase(
      {required ExploreAppRepository exploreAppRepository})
      : _exploreAppRepository = exploreAppRepository;

  @override
  Future<Either<Failure, List<PostEntity>>> call(
      GetShortsOfTagUseCaseParams params) async {
    return await _exploreAppRepository.getShortsOfTag(params.tag);
  }
}

class GetShortsOfTagUseCaseParams {
  final String tag;

  GetShortsOfTagUseCaseParams({required this.tag});
}
