import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/explore/domain/repositories/explore_app_repository.dart';

class GetHashtagTopPostsUseCase
    implements UseCase<List<PostEntity>, GetHashtagTopPostsUseCaseParams> {
  final ExploreAppRepository _exploreAppRepository;

  GetHashtagTopPostsUseCase(
      {required ExploreAppRepository exploreAppRepository})
      : _exploreAppRepository = exploreAppRepository;

  @override
  Future<Either<Failure, List<PostEntity>>> call(
      GetHashtagTopPostsUseCaseParams params) async {
    return await _exploreAppRepository.getTopPostsOfHashTags(params.tag);
  }
}

class GetHashtagTopPostsUseCaseParams {
  final String tag;

  GetHashtagTopPostsUseCaseParams({required this.tag});
}
