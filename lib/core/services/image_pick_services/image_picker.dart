import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  static final ImagePicker _picker = ImagePicker();

  static Future<File?> pickOneImage() async {
    final result =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 40);
    if (result == null) return null;
    return File(result.path);
  }

  static Future<List<File?>> pickMultipleImages() async {
    final result = await _picker.pickMultiImage(limit: 3, imageQuality: 30);
    final List<File?> resultToFile = [];
    for (var i in result) {
      resultToFile.add(File(i.path));
    }
    return resultToFile;
  }
}
