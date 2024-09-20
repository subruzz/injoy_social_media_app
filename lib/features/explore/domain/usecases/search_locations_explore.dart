import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/explore/domain/entities/explore_search_location.dart';
import 'package:social_media_app/features/explore/domain/repositories/explore_app_repository.dart';

class SearchLocationsExploreUseCase
    implements
        UseCase<List<ExploreLocationSearchEntity>,
            SearchLocationsExploreUseCaseParams> {
  final ExploreAppRepository _exploreAppRepository;

  SearchLocationsExploreUseCase(
      {required ExploreAppRepository exploreAppRepository})
      : _exploreAppRepository = exploreAppRepository;

  @override
  Future<Either<Failure, List<ExploreLocationSearchEntity>>> call(
      SearchLocationsExploreUseCaseParams params) async {
    return await _exploreAppRepository.searchLocationInExplore(params.query);
  }
}

class SearchLocationsExploreUseCaseParams {
  final String query;

  SearchLocationsExploreUseCaseParams({required this.query});
}
