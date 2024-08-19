import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager/platform_utils.dart';

import '../method_channel.dart/app_toast.dart';

class AssetServices {
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

  static Future<List<Uint8List>?> pickMultipleImagesAsBytes() async {
    final result = await _picker.pickMultiImage(limit: 3, imageQuality: 30);
    final List<Uint8List> resultToBytes = [];

    for (var i in result) {
      final bytes = await i.readAsBytes();
      resultToBytes.add(bytes);
    }
    if (resultToBytes.isEmpty) {
      return null;
    }
    return resultToBytes;
  }

  static Future<File?> compressImage(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 88,
    );
    if (result == null) return null;
    return File(result.path);
  }

  //to save images to gallery
  static Future<void> saveImageWithPath({required String imageUrl}) async {
    ToastService.showToast('Media will be downloaded shortly...');
    try {
      final HttpClient client = HttpClient();
      final HttpClientRequest req = await client.getUrl(Uri.parse(imageUrl));
      final HttpClientResponse resp = await req.close();

      final File file = File(await downloadPath());

      resp.listen(
        (List<int> data) {
          file.writeAsBytesSync(data, mode: FileMode.append);
        },
        onDone: () async {
          log('write image to file success: $file');
          await checkRequest(() async {
            final AssetEntity? asset =
                await PhotoManager.editor.saveImageWithPath(
              file.path,
              title: '${DateTime.now().millisecondsSinceEpoch}.jpg',
            );
            log('saved asset: $asset');
          });
          client.close();
        },
      );
      ToastService.showToast('Media Downloaded');
    } catch (e) {
      ToastService.showToast(
          'There was an error downloading the media,Please try again!');
    }
  }

  static Future<void> checkRequest(void Function() onAuth) async {
    final state = await PhotoManager.requestPermissionExtend(
      requestOption: const PermissionRequestOption(
        iosAccessLevel: IosAccessLevel.addOnly,
      ),
    );
    if (!state.isAuth) {
      return;
    }
    onAuth();
  }

  static Future<String> downloadPath() async {
    final int name = DateTime.now().microsecondsSinceEpoch ~/
        Duration.microsecondsPerMillisecond;

    String dir;

    if (Platform.isIOS || Platform.isMacOS) {
      dir = (await getApplicationSupportDirectory()).absolute.path;
    } else if (Platform.isAndroid) {
      dir = (await getExternalStorageDirectories(
        type: StorageDirectory.downloads,
      ))![0]
          .absolute
          .path;
    } else if (PlatformUtils.isOhos) {
      dir = (await getDownloadsDirectory())!.absolute.path;
    } else {
      dir = (await getDownloadsDirectory())!.absolute.path;
    }

    return '$dir/$name.jpg';
  }
}
