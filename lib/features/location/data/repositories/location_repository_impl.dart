// lib/features/location/data/repositories/location_repository_impl.dart

import 'package:fpdart/fpdart.dart';
import 'package:geocoding/geocoding.dart';
import 'package:social_media_app/core/const/enums/location_enum.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/location/data/datasource/local/location_local_datasource.dart';
import 'package:social_media_app/features/location/data/datasource/remote/search_location.dart';
import 'package:social_media_app/features/location/data/models/location_search_model.dart';
import 'package:social_media_app/features/location/domain/entities/location.dart';
import '../../domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationLocalDataSource _locationLocalDataSource;
  final SearchLocationDataSource _locationDataSource;
  LocationRepositoryImpl(this._locationDataSource,
      {required LocationLocalDataSource locationLocalDataSource})
      : _locationLocalDataSource = locationLocalDataSource;

  // @override
  // Future<Either<Failure, bool>> handleLocationPermission() async {
  //   try {
  //     final hasPermission =
  //         await _locationLocalDataSource.handleLocationPermission();
  //     return right(hasPermission);
  //   } catch (e) {
  //     return left(
  //       Failure('Error Occured while getting permissiion'),
  //     );
  //   }
  // }

  // @override
  // Future<Either<Failure, Position>> getCurrentPosition() async {
  //   try {
  //     final currentPosition =
  //         await _locationLocalDataSource.getCurrentPosition();
  //     return right(currentPosition);
  //   } catch (e) {
  //     return left(
  //       Failure('Error Occured while getting current Location'),
  //     );
  //   }
  // }

  @override
  Future<Either<Failure, UserLocation>> getAddressFromLatLng() async {
    try {
      final hasPermission =
          await _locationLocalDataSource.handleLocationPermission();
      if (hasPermission != LocationStatus.locationPermissionAllowed) {
        return right(UserLocation(locationStatus: hasPermission));
      }
      final postion = await _locationLocalDataSource.getCurrentPosition();
      final currentLocation =
          await _locationLocalDataSource.getAddressFromLatLng(postion);
      return right(UserLocation(
          locationStatus: LocationStatus.locationPermissionAllowed,
          latitude: postion.latitude,
          longitude: postion.longitude,
          currentLocation: currentLocation));
    } catch (e) {
      return left(
        Failure('Error Occured while getting current Location'),
      );
    }
  }

  @override
  Future<Either<Failure, List<SuggestedLocation>>> searchLocation(
      String query) async {
    try {
      final locations = await _locationDataSource.fetchSugestedLocation(query);
      return Right(locations);
    } on MainException catch (e) {
      return Left(Failure(e.errorMsg));
    }
  }
}
