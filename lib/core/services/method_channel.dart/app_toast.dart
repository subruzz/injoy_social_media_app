import 'package:flutter/services.dart';

/// A service class for displaying toast messages on the platform.
class ToastService {
  // Method channel for communicating with the native platform.
  static const MethodChannel _channel =
      MethodChannel('com.example.social_media_app/toast');

  /// Displays a toast message on the screen.
  ///
  /// [message]: The message to be displayed in the toast.
  static Future<void> showToast(String message) async {
    try {
      // Invokes the native method to show the toast with the given message.
      await _channel.invokeMethod('showToast', {'message': message});
    } on PlatformException catch (_) {
      // Catch platform exceptions and ignore them.
      return;
    }
  }
}
