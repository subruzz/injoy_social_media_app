import 'package:url_launcher/url_launcher.dart';

class MapService {
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
