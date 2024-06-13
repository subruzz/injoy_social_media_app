import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/location_enum.dart';
import 'package:social_media_app/core/usecases/usecase.dart';
import 'package:social_media_app/features/location/domain/usecases/get_location.dart';
part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GetLocationUseCase _getLocationUseCase;
  LocationBloc(this._getLocationUseCase) : super(LocationInitial()) {
    on<LocationEvent>((event, emit) {
      emit(LocationLoading());
    });
    on<LocationCurrentEvent>(_currentLocation);
  }

  FutureOr<void> _currentLocation(
      LocationCurrentEvent event, Emitter<LocationState> emit) async {
    final res = await _getLocationUseCase(NoParams());
    res.fold((failure) {
      emit(LocationFailure());
    }, (success) {
      if (success.locationStatus == LocationStatus.locationNotEnabled) {
        emit(LocationNotOnState());
      } else if (success.locationStatus ==
          LocationStatus.locationPermissionDenied) {
        emit(LocationPermissionDenied());
      } else if (success.locationStatus ==
          LocationStatus.locationPermissionDeniedForever) {
        emit(LocatonPermissionForeverDenied());
      } else {
        emit(LocationSuccess(
            locationName: success.currentLocation ?? '',
            latitue: success.latitude ?? 0,
            longitude: success.longitude ?? 0));
      }
    });
  }
}
