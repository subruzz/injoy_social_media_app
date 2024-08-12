import 'dart:developer';

import 'package:flutter/services.dart';
//! Not implemented
class VideoService {
  static const MethodChannel _channel =
      MethodChannel('com.example.social_media_app/video_trimmer');

  // Method to trim video
  Future<String?> trimVideo(String videoPath) async {
    try {
      final String? trimmedVideoPath =
          await _channel.invokeMethod('trimVideo', {'videoPath': videoPath});
      return trimmedVideoPath;
    } catch (e) {
      log("Error trimming video: $e");
      return null;
    }
  }
}
