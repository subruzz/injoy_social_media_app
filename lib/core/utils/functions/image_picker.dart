import 'dart:io';

import 'package:image_picker/image_picker.dart';

Future<File?> selecteImage() async {
  final ImagePicker imgPicker = ImagePicker();
  final result =
      await imgPicker.pickImage(source: ImageSource.gallery, imageQuality: 40);
  if (result == null) return null;
  return File(result.path);
}
