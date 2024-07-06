import 'package:geocoding/geocoding.dart';

extension PlacemarkExtension on Placemark {
  String toReadableString() {
    return [
      street,
      locality,
      subAdministrativeArea,
      administrativeArea,
      postalCode,
      country
    ].where((part) => part != null && part.isNotEmpty).join(', ');
  }
}
