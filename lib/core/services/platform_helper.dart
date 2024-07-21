import 'dart:io'; // For mobile platforms
import 'package:flutter/foundation.dart' show kIsWeb; // For web

enum TargetPlatform {
  android,
  iOS,
  web,
  unknown,
}

TargetPlatform detectPlatform() {
  if (kIsWeb) {
    return TargetPlatform.web;
  } else if (Platform.isAndroid) {
    return TargetPlatform.android;
  } else if (Platform.isIOS) {
    return TargetPlatform.iOS;
  } else {
    return TargetPlatform.unknown;
  }
}
