part of 'location_bloc.dart';

sealed class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

final class LocationCurrentEvent extends LocationEvent {}

final class GetSuggestedLocation extends LocationEvent {
  final String query;

  const GetSuggestedLocation({required this.query});
}
