import 'package:url_launcher/url_launcher.dart';

/// A service to handle email-related actions.
class EmailService {
  /// Opens the Gmail app with a pre-defined recipient, subject, and body.
  ///
  /// This method uses the `mailto` URL scheme to create an email.
  /// If the Gmail app cannot be opened, it throws an exception.
  static Future<void> openGmail() async {
    const url = 'mailto:subruzz4424@gmail.com?subject=Help&body=';
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
