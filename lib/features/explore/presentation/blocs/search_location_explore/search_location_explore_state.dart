part of 'search_location_explore_cubit.dart';

sealed class SearchLocationExploreState extends Equatable {
  const SearchLocationExploreState();

  @override
  List<Object> get props => [];
}

final class SearchLocationExploreInitial extends SearchLocationExploreState {}

final class SearchLocationLoading extends SearchLocationExploreState {}

final class SearchLocationFailure extends SearchLocationExploreState {
  final String erroMsg;

  const SearchLocationFailure({required this.erroMsg});
}

final class SearchLocationSuccess extends SearchLocationExploreState {
  final List<ExploreLocationSearchEntity> searchedLocations;

  const SearchLocationSuccess({required this.searchedLocations});
}
