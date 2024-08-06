import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/location/data/models/location_search_model.dart';
import 'package:social_media_app/features/location/domain/repositories/location_repository.dart';

class SearchLocationUseCase
    implements UseCase<List<SuggestedLocation>, SearchLocationUseCaseParams> {
  final LocationRepository _locationRepository;

  SearchLocationUseCase({required LocationRepository locationRepository})
      : _locationRepository = locationRepository;
  @override
  Future<Either<Failure, List<SuggestedLocation>>> call(params) async {
    return await _locationRepository.searchLocation(params.query);
  }
}

class SearchLocationUseCaseParams {
  final String query;

  SearchLocationUseCaseParams({required this.query});
}
