import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/explore/domain/repositories/explore_app_repository.dart';
import 'package:social_media_app/features/post/domain/enitities/hash_tag.dart';

class SearchHashTagsUseCase
    implements UseCase<List<HashTag>, SearchHashTagsUseCaseParams> {
  final ExploreAppRepository _exploreAppRepository;

  SearchHashTagsUseCase({required ExploreAppRepository exploreAppRepository})
      : _exploreAppRepository = exploreAppRepository;

  @override
  Future<Either<Failure, List<HashTag>>> call(
      SearchHashTagsUseCaseParams params) async {
    return await _exploreAppRepository.searchHashTags(params.query);
  }
}

class SearchHashTagsUseCaseParams {
  final String query;

  SearchHashTagsUseCaseParams({required this.query});
}
