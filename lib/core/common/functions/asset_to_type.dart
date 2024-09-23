import 'dart:developer';
import 'dart:io';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/core/services/assets/asset_model.dart';

Future<SelectedByte> convertAssetToSelectedByte(AssetEntity asset) async {
  try {
    final bool isImage = asset.type == AssetType.image;

    // For mobile, use both File and Uint8List
    final File? tempFile = await asset.file;
    log('file is $tempFile');
    if (tempFile == null) {
      throw Exception('Failed to get file from asset');
    }
  
    return SelectedByte(
      mediaType: isImage ? MediaType.photo : MediaType.video,
      selectedFile: tempFile,
    );
  } catch (e) {
    // Handle any unexpected errors
    throw Exception('Conversion failed: $e');
  }
}
