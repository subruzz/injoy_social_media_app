import 'package:flutter/material.dart';
import 'package:giphy_picker/giphy_picker.dart';

import '../app_config/app_border_radius.dart';

Future<GiphyGif?> pickGif(BuildContext context) async {
  GiphyGif? gif;
  try {
    gif = await GiphyPicker.pickGif(
        showPreviewPage: false,
        context: context,
        apiKey: 'HN4nOunS6Eg8OHF5LLDRibdbHGrpm6l8');
  } catch (_) {
    return null;
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
