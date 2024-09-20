import 'package:url_launcher/url_launcher.dart';

/// A service to handle map-related actions.
class MapService {
  /// Opens Google Maps with a specified location based on latitude and longitude.
  ///
  /// [latitude]: The latitude of the location to be displayed.
  /// [longitude]: The longitude of the location to be displayed.
  ///
  /// This method constructs a URL for Google Maps and attempts to launch it.
  /// If the URL cannot be launched, it throws an exception.
  static Future<void> openMap({
    required double latitude,
    required double longitude,
  }) async {
    final String url =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
