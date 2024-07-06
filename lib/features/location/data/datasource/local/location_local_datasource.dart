// lib/features/location/data/datasources/location_remote_data_source.dart

import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:social_media_app/core/const/location_enum.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/extensions/placemark.dart';

abstract interface class LocationLocalDataSource {
  Future<LocationStatus> handleLocationPermission();
  Future<String> getAddressFromLatLng(Position position);
  Future<Position> getCurrentPosition();
}

class LocationLocalDataSourceImpl implements LocationLocalDataSource {
  @override
  Future<LocationStatus> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are disabled. Please enable the services
      return LocationStatus.locationNotEnabled;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Location permissions are denied
        return LocationStatus.locationPermissionDenied;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Location permissions are permanently denied, we cannot request permissions.
      return LocationStatus.locationPermissionDeniedForever;
    }
    return LocationStatus.locationPermissionAllowed;
  }

  @override
  Future<Position> getCurrentPosition() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  @override
  Future<String> getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placeMarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placeMarks[0];

      return place.toReadableString();
    } catch (e) {
      throw const MainException();
    }
  }

  // Future<List<LocationModel>> searchLocation(String query) async {
  //   // Replace with your API call logic to search for locations based on the query.
  //   // For example:
  //   final response =
  //       await http.get('https://api.example.com/search?query=$query');
  //   if (response.statusCode == 200) {
  //     // Parse response and return list of LocationModel
  //     final List jsonData = json.decode(response.body);
  //     return jsonData.map((json) => LocationModel.fromJson(json)).toList();
  //   } else {
  //     throw SearchException();
  //   }
  // }
}
