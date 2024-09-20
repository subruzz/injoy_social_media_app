import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager/platform_utils.dart';

import '../method_channel.dart/app_toast.dart';

/// A service class for managing image and video assets.
class AssetServices {
  static final ImagePicker _picker = ImagePicker();

  /// Picks a single image from the gallery with a specified image quality.
  ///
  /// Returns a [File] object of the picked image or `null` if no image is selected.
  static Future<File?> pickOneImage() async {
    final result =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 40);
    if (result == null) return null;
    return File(result.path);
  }

  /// Picks multiple images from the gallery with a specified image quality.
  ///
  /// Returns a list of [File] objects for the picked images, or an empty list if none are selected.
  static Future<List<File?>> pickMultipleImages() async {
    final result = await _picker.pickMultiImage(limit: 3, imageQuality: 30);
    final List<File?> resultToFile = [];
    for (var i in result) {
      resultToFile.add(File(i.path));
    }
    return resultToFile;
  }

  /// Picks multiple images from the gallery and returns them as byte data.
  ///
  /// Returns a list of [Uint8List] containing the byte data of the picked images, or `null` if none are selected.
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

  /// Picks a single image from the gallery and returns it as byte data.
  ///
  /// Returns the byte data of the picked image as [Uint8List], or `null` if no image is selected.
  static Future<Uint8List?> pickSingleImageAsBytes() async {
    final result =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 30);
    if (result == null) {
      return null;
    }
    final bytes = await result.readAsBytes();
    return bytes;
  }

  /// Compresses an image file to a specified target path with a defined quality.
  ///
  /// Returns the compressed [File] object or `null` if the compression fails.
  static Future<File?> compressImage(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 88,
    );
    if (result == null) return null;
    return File(result.path);
  }

  /// Saves an image from a URL to the device's gallery.
  ///
  /// Displays a toast message indicating that the media will be downloaded.
  /// Logs success or error messages based on the download outcome.
  static Future<void> saveImageWithPath({required String imageUrl}) async {
    log('save image called');

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

  /// Checks for permission to access the device's photo library.
  ///
  /// Calls the [onAuth] function if permission is granted.
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

  /// Retrieves the path to download images, creating a unique file name.
  ///
  /// Returns the full file path as a [String].
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

  /// Saves a video from a URL to the device's gallery.
  ///
  /// Logs the process and handles errors during the download.
  static Future<void> saveVideo({required String videoUrl}) async {
    log('save video called');
    final HttpClient client = HttpClient();
    HttpClientRequest? req;
    HttpClientResponse? resp;

    try {
      req = await client.getUrl(Uri.parse(videoUrl));
      resp = await req.close();

      final String name = videoName(videoUrl);

      final Directory tmpDir = await getTemporaryDirectory();
      final File file = File('${tmpDir.path}/$name');

      // Delete the file if it already exists
      if (file.existsSync()) {
        file.deleteSync();
      }

      // Write the file content from the response
      resp.listen(
        (List<int> data) {
          log('listening download of asset video');
          file.writeAsBytesSync(data, mode: FileMode.append);
        },
        onDone: () async {
          try {
            await checkRequest(() async {
              final AssetEntity? asset =
                  await PhotoManager.editor.saveVideo(file, title: name);
              log('saved asset: $asset');
            });
          } catch (e) {
            log('Failed to save video to gallery: $e');
          } finally {
            client.close();
          }
        },
        onError: (e) {
          log('Error while downloading video: $e');
          client.close();
        },
        cancelOnError: true,
      );
    } catch (e) {
      log('Failed to download video: $e');
      client.close();
    }
  }

  /// Generates a name for the video based on its URL and the current timestamp.
  ///
  /// Returns the generated name as a [String].
  static String videoName(String videoUrl) {
    final String extName =
        Uri.parse(videoUrl).pathSegments.last.split('.').last;
    final int name = DateTime.now().microsecondsSinceEpoch ~/
        Duration.microsecondsPerMillisecond;
    return '$name.$extName';
  }
}
