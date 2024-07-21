import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:giphy_picker/giphy_picker.dart';

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
