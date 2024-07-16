import 'package:social_media_app/core/const/location_enum.dart';

class UserLocation {
  final double? latitude;
  final double? longitude;
  final LocationStatus? locationStatus;
  final String? currentLocation;
  UserLocation(
      {this.latitude,
      this.currentLocation,
      this.longitude,
       this.locationStatus});
}
