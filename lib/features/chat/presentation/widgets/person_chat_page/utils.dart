import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:giphy_picker/giphy_picker.dart';
import 'package:social_media_app/core/const/app_config/app_border_radius.dart';

class SelectedImagesDetails {
  List<SelectedByte> selectedFiles;
  bool multiSelectionMode;

  SelectedImagesDetails({
    required this.selectedFiles,
    required this.multiSelectionMode,
  });
}

class SelectedByte {
  File? selectedFile; // File may be null for web
  Uint8List selectedByte;
  MediaType mediaType;

  SelectedByte({
    required this.mediaType,
    this.selectedFile, // Optional for web
    required this.selectedByte,
  });
}

enum MediaType {
  audio,
  video,
  photo,
  none,
}

Future<GiphyGif?> pickGif(BuildContext context) async {
  GiphyGif? gif;
  try {
    gif = await GiphyPicker.pickGif(
        showPreviewPage: false,
        context: context,
        apiKey: 'HN4nOunS6Eg8OHF5LLDRibdbHGrpm6l8');
  } catch (e) {
    log('errror');
  }
  return gif;
}

final class ChatConstants {
  static Radius commonborderRadius12 = Radius.circular(
    AppBorderRadius.getRadius(12),
  );
  static Radius commonborderRadius24 = Radius.circular(
    AppBorderRadius.getRadius(24),
  );
  static Gradient chatGradient = const LinearGradient(
    colors: [
      Color.fromARGB(255, 240, 93, 130),
      Color(0xFFfe526a),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
