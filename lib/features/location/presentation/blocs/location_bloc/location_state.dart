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
  final String locationName;
  final double latitue;
  final double longitude;

  const LocationSuccess(
      {required this.locationName,
      required this.latitue,
      required this.longitude});
}
