import 'package:geocoding/geocoding.dart';

/// Extension for adding utility methods to the [Placemark] class.
extension PlacemarkExtension on Placemark {
  /// Converts the [Placemark] instance into a human-readable string.
  ///
  /// This method constructs a string representation of the placemark
  /// by joining its address components (street, locality, 
  /// sub-administrative area, administrative area, postal code, and country).
  /// It excludes any null or empty parts from the result.
  ///
  /// Example:
  /// ```dart
  /// Placemark placemark = //... get placemark
  /// String readableAddress = placemark.toReadableString();
  /// print(readableAddress); // Outputs: "123 Main St, City, State, 12345, Country"
  /// ```
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
