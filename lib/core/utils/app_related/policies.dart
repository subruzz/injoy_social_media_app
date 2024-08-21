import 'dart:developer';
import 'package:url_launcher/url_launcher.dart';

class AppPolicies {
  AppPolicies._();

  static Future<void> goToPrivacyPolicies() async {
    final Uri url = Uri.parse(
        'https://doc-hosting.flycricket.io/injoy-privacy-policy/04343e77-ebc1-437e-a3a5-8968625044cc/privacy');

    try {
      await launchUrl(url);
    } catch (e) {
      log('Error occured for policy opening : $e');
    }
  }

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
