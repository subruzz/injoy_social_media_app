import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:social_media_app/core/services/assets/asset_services.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import '../assets/asset_model.dart';
import '../method_channel.dart/video_thumbnail.dart';
import '../../utils/other/id_generator.dart';

/// A service class for handling asset uploads to Firebase Storage.
class FirebaseStorageService {
  final FirebaseStorage firebaseStorage; // Instance of FirebaseStorage.

  FirebaseStorageService({required this.firebaseStorage});

  /// Uploads a list of assets (images or videos) to Firebase Storage.
  ///
  /// [assets]: List of selected media files to upload.
  /// [postImgesFromWeb]: Optional list of image bytes from the web.
  /// [reference]: Reference path in Firebase Storage.
  /// [needThumbnail]: Flag to indicate if a thumbnail is needed for videos.
  /// [isPhoto]: Flag to indicate if the assets are photos.
  Future<AssetStorageItems> uploadListOfAssets({
    required List<SelectedByte> assets,
    List<Uint8List>? postImgesFromWeb,
    required String reference,
    bool needThumbnail = false,
    bool isPhoto = true,
  }) async {
    try {
      AssetStorageItems assetItem = AssetStorageItems();
      List<String> assetUrls = [];

      // Upload images from the web, if provided.
      if (postImgesFromWeb != null) {
        for (var asset in postImgesFromWeb) {
          final res = await uploadSingleAsset(uinAsset: asset, reference: reference);
          if (res == null) {
            continue;
          }
          assetUrls.add(res);
        }
        assetItem = assetItem.copyWith(urls: assetUrls);
        return assetItem;
      }

      // Upload selected assets.
      if (isPhoto) {
        for (var asset in assets) {
          final res = await uploadSingleAsset(asset: asset.selectedFile!, reference: reference);
          if (res == null) {
            continue;
          }
          assetUrls.add(res);
        }
        assetItem = assetItem.copyWith(urls: assetUrls);
      } else {
        // Handle video uploads and thumbnails.
        if (needThumbnail) {
          final thumbnailLocal = await VideoThumbnail.thumbnailFile(
            video: assets.first.selectedFile!.path,
            imageFormat: ImageFormat.PNG,
            timeMs: 1000,
            maxHeight: 300,
            maxWidth: 300,
            quality: 90,
          );

          final thumbnailCloud = await uploadSingleAsset(asset: File(thumbnailLocal!), reference: '$reference/thumbnail');
          assetItem = assetItem.copyWith(extra: thumbnailCloud);
        }
        final vdo = await uploadSingleAsset(isPhoto: false, asset: assets.first.selectedFile!, reference: reference);
        assetItem = assetItem.copyWith(url: vdo);
      }

      return assetItem;
    } catch (e) {
      throw Exception('Error uploading assets: ${e.toString()}');
    }
  }

  /// Uploads a single asset (image or video) to Firebase Storage.
  ///
  /// [asset]: The media file to upload.
  /// [uinAsset]: Optional Uint8List asset data for direct uploads.
  /// [reference]: Reference path in Firebase Storage.
  /// [isPhoto]: Flag to indicate if the asset is a photo.
  Future<String?> uploadSingleAsset({
    File? asset,
    Uint8List? uinAsset,
    required String reference,
    bool isPhoto = true,
  }) async {
    try {
      if (isThatMobile && asset == null) return null;
      String imageId = IdGenerator.generateUniqueId();

      // Compress the image if it is a photo.
      File? compressedFile;
      if (isPhoto && uinAsset == null) {
        final directory = await getTemporaryDirectory();
        String targetPath = '${directory.path}/compressed_$imageId.jpg';
        compressedFile = await AssetServices.compressImage(asset!, targetPath);
      }

      // Create a unique reference for the file.
      Reference ref = firebaseStorage.ref().child(reference).child(imageId);

      // Upload the compressed image or Uint8List data to Firebase Storage.
      UploadTask task = uinAsset != null
          ? ref.putData(uinAsset)
          : ref.putFile(compressedFile ?? asset!);
      String? downLURl;
      await task.whenComplete(() async {
        var downloadUrl = await ref.getDownloadURL();
        await compressedFile?.delete();
        downLURl = downloadUrl;
      });
      return downLURl;
    } catch (e) {
      print('value of assets are ${e.toString()}');
      throw Exception('Error uploading asset: ${e.toString()}');
    }
  }
}

/// A model class representing the storage items uploaded to Firebase.
class AssetStorageItems {
  final List<String> urls; // List of asset URLs.
  final String? url; // URL of the main asset.
  final String? extra; // URL of any extra asset (e.g., thumbnail).
  final bool isPhoto; // Flag indicating if the item is a photo.

  AssetStorageItems({
    this.urls = const [],
    this.url,
    this.extra,
    this.isPhoto = true,
  });

  /// Creates a copy of the current instance with updated fields.
  AssetStorageItems copyWith({
    List<String>? urls,
    String? url,
    String? extra,
    bool? isPhoto,
  }) {
    return AssetStorageItems(
      urls: urls ?? this.urls,
      url: url ?? this.url,
      extra: extra ?? this.extra,
      isPhoto: isPhoto ?? this.isPhoto,
    );
  }
}
