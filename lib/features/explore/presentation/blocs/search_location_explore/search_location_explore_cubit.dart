import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/explore/domain/entities/explore_search_location.dart';
import 'package:social_media_app/features/explore/domain/usecases/search_locations_explore.dart';

part 'search_location_explore_state.dart';

class SearchLocationExploreCubit extends Cubit<SearchLocationExploreState> {
  final SearchLocationsExploreUseCase _searchLocationsExploreUseCase;
  SearchLocationExploreCubit(this._searchLocationsExploreUseCase)
      : super(SearchLocationExploreInitial());

  Future<void> searchLocations(String query) async {
    if (query.isEmpty) {
      return emit(SearchLocationExploreInitial());
    }
    emit(SearchLocationLoading());
    final res = await _searchLocationsExploreUseCase(
        SearchLocationsExploreUseCaseParams(query: query));
    res.fold((failure) => emit(SearchLocationFailure(erroMsg: failure.message)),
        (success) {
      emit(SearchLocationSuccess(searchedLocations: success, query: query));
    });
  }
}
