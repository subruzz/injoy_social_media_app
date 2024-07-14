import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/explore/domain/repositories/explore_app_repository.dart';

class GetRecentPostsHashtagUseCase
    implements UseCase<List<PostEntity>, GetRecentPostsHashtagUseCaseParams> {
  final ExploreAppRepository _exploreAppRepository;

  GetRecentPostsHashtagUseCase(
      {required ExploreAppRepository exploreAppRepository})
      : _exploreAppRepository = exploreAppRepository;

  @override
  Future<Either<Failure, List<PostEntity>>> call(
      GetRecentPostsHashtagUseCaseParams params) async {
    return await _exploreAppRepository.searchRecentPostsOfHashTags(params.tag);
  }
}

class GetRecentPostsHashtagUseCaseParams {
  final String tag;

  GetRecentPostsHashtagUseCaseParams({required this.tag});
}
