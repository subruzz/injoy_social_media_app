import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/explore/domain/repositories/explore_app_repository.dart';

class GetRecommendedPostUseCase
    implements UseCase<List<PostEntity>, GetRecommendedPostUseCaseParams> {
  final ExploreAppRepository _exploreAppRepository;

  GetRecommendedPostUseCase(
      {required ExploreAppRepository exploreAppRepository})
      : _exploreAppRepository = exploreAppRepository;

  @override
  Future<Either<Failure, List<PostEntity>>> call(
      GetRecommendedPostUseCaseParams params) async {
    return await _exploreAppRepository.getRecommended(params.query);
  }
}

class GetRecommendedPostUseCaseParams {
  final String query;

  GetRecommendedPostUseCaseParams({required this.query});
}
