
import 'package:fpdart/fpdart.dart';
import 'package:geocoding/geocoding.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/location/domain/entities/location.dart';

abstract interface class LocationRepository {
  Future<Either<Failure, UserLocation>> getAddressFromLatLng();
  Future<Either<Failure, List<Location>>> searchLocation(String query);
}