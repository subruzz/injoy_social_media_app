import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<File?> compressImage(File file, String targetPath) async {
  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    targetPath,
    quality: 88,
  );
  if (result == null) return null;
  return File(result.path);
}
