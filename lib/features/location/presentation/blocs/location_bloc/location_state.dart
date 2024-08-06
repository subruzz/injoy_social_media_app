part of 'location_bloc.dart';

sealed class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

final class LocationInitial extends LocationState {}

final class LocationLoading extends LocationState {}

final class LocationPermissionDenied extends LocationState {}

final class LocatonPermissionForeverDenied extends LocationState {}

final class LocationNotOnState extends LocationState {}

final class LocationFailure extends LocationState {}

final class LocationSuccess extends LocationState {
  final UserLocation location;

  const LocationSuccess({required this.location});
}

class LocationSearchLoaded extends LocationState {
  final List<SuggestedLocation> suggestions;

  const LocationSearchLoaded(this.suggestions);

  @override
  List<Object> get props => [suggestions];
}
