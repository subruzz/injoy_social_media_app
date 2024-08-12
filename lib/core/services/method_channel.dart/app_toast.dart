import 'package:flutter/services.dart';

class ToastService {
  static const MethodChannel _channel =
      MethodChannel('com.example.social_media_app/toast');

  static Future<void> showToast(String message) async {
    try {
      await _channel.invokeMethod('showToast', {'message': message});
    } on PlatformException catch (_) {
      return;
    }
  }
}
