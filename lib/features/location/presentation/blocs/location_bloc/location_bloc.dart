import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/enums/location_enum.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/location/data/models/location_search_model.dart';
import 'package:social_media_app/features/location/domain/entities/location.dart';
import 'package:social_media_app/features/location/domain/usecases/get_location.dart';
import 'package:social_media_app/features/location/domain/usecases/search_location.dart';
part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GetLocationUseCase _getLocationUseCase;
  final SearchLocationUseCase _searchLocationUseCase;
  LocationBloc(this._getLocationUseCase, this._searchLocationUseCase)
      : super(LocationInitial()) {
    on<LocationEvent>((event, emit) {
      emit(LocationLoading());
    });
    on<GetSuggestedLocation>(_getSuggestedLocation);
    on<LocationCurrentEvent>(_currentLocation);
  }

  FutureOr<void> _currentLocation(
      LocationCurrentEvent event, Emitter<LocationState> emit) async {
    final res = await _getLocationUseCase(NoParams());
    res.fold((failure) {
      emit(LocationFailure());
    }, (success) {
      switch (success.locationStatus) {
        case LocationStatus.locationNotEnabled:
          emit(LocationNotOnState());
          break;
        case LocationStatus.locationPermissionDenied:
          emit(LocationPermissionDenied());
          break;
        case LocationStatus.locationPermissionDeniedForever:
          emit(LocatonPermissionForeverDenied());
          break;
        case LocationStatus.locationPermissionAllowed:
          emit(LocationSuccess(location: success));
          break;
        case null:
          emit(LocationFailure());
      }
    });
  }

  FutureOr<void> _getSuggestedLocation(
      GetSuggestedLocation event, Emitter<LocationState> emit) async {
    final res = await _searchLocationUseCase(
        SearchLocationUseCaseParams(query: event.query));
    res.fold((failure) => emit(LocationFailure()),
        (success) =>emit( LocationSearchLoaded(success)));
  }
}
