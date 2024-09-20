import 'dart:developer';
import 'package:url_launcher/url_launcher.dart';

/// A service to handle navigation to app policies such as privacy policies and terms and conditions.
class AppPolicies {
  AppPolicies._();

  /// Opens the privacy policy URL in the default browser.
  ///
  /// This method constructs a URI for the privacy policy and attempts to launch it.
  /// If there is an error during the launch, it logs the error.
  static Future<void> goToPrivacyPolicies() async {
    final Uri url = Uri.parse(
        'https://doc-hosting.flycricket.io/injoy-privacy-policy/04343e77-ebc1-437e-a3a5-8968625044cc/privacy');

    try {
      await launchUrl(url);
    } catch (e) {
      log('Error occurred while opening privacy policy: $e');
    }
  }

  /// Opens the terms and conditions URL in the default browser.
  ///
  /// This method constructs a URI for the terms and conditions and attempts to launch it.
  /// If there is an error during the launch, it logs the error.
  static Future<void> goToTermsAndConditions() async {
    final Uri url = Uri.parse(
        'https://doc-hosting.flycricket.io/injoy-terms-of-use/010c2132-c08a-495d-908d-87be695b84fc/terms');

    try {
      await launchUrl(url);
    } catch (e) {
      log('Unable to launch terms and conditions URL: $e');
    }
  }
}
