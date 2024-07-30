import 'dart:typed_data';
import 'dart:io';
import 'package:photo_manager/photo_manager.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/utils.dart';

Future<SelectedByte> convertAssetToSelectedByte(AssetEntity asset) async {
  try {
    final Uint8List? fileData = await asset.originBytes;
    final bool isImage = asset.type == AssetType.image;

    if (fileData == null) {
      throw Exception('Failed to get bytes from asset');
    }

    if (kIsWeb) {
      // For web, only use Uint8List
      return SelectedByte(
        mediaType: isImage ? MediaType.photo : MediaType.video,
        selectedFile: null, // No File support on web
        selectedByte: fileData,
      );
    } else {
      // For mobile, use both File and Uint8List
      final File? tempFile = await asset.file;

      if (tempFile == null) {
        throw Exception('Failed to get file from asset');
      }

      return SelectedByte(
        mediaType: isImage ? MediaType.photo : MediaType.video,
        selectedFile: tempFile,
        selectedByte: fileData,
      );
    }
  } catch (e) {
    // Handle any unexpected errors
    throw Exception('Conversion failed: $e');
  }
}