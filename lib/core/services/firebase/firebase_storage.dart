import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:social_media_app/core/services/assets/asset_services.dart';
import '../../../features/chat/presentation/widgets/person_chat_page/utils.dart';
import '../method_channel.dart/video_thumbnail.dart';
import '../../utils/other/id_generator.dart';

class FirebaseStorageService {
  final FirebaseStorage firebaseStorage;

  FirebaseStorageService({required this.firebaseStorage});

  Future<AssetStorageItems> uploadListOfAssets(
      {required List<SelectedByte> assets,
      required String reference,
      bool needThumbnail = false,
      bool isPhoto = true}) async {
    try {
      AssetStorageItems assetItem = AssetStorageItems();
      List<String> assetUrls = [];

      if (isPhoto) {
        for (var asset in assets) {
          final res = await uploadSingleAsset(
              asset: asset.selectedFile!, reference: reference);
          if (res == null) {
            continue;
          }
          assetUrls.add(res);
        }
        assetItem = assetItem.copyWith(urls: assetUrls);
      } else {
        if (needThumbnail) {
          final thumbnailLocal = await VideoThumbnail.thumbnailFile(
              video: assets.first.selectedFile!.path,
              imageFormat: ImageFormat.PNG,
              timeMs: 1000,
              maxHeight: 300, // Increase height
              maxWidth: 300, // Increase width
              quality: 90);

          final thumbnailCloud = await uploadSingleAsset(
              asset: File(thumbnailLocal!), reference: '$reference/thumbnail');
          assetItem = assetItem.copyWith(extra: thumbnailCloud);
        }
        final vdo = await uploadSingleAsset(
            isPhoto: false,
            asset: assets.first.selectedFile!,
            reference: reference);
        assetItem = assetItem.copyWith(url: vdo);
      }

      return assetItem;
    } catch (e) {
      throw Exception('Error uploading assets: ${e.toString()}');
    }
  }

  Future<String?> uploadSingleAsset({
    required File asset,
    required String reference,
    bool isPhoto = true,
  }) async {
    try {
      final directory = await getTemporaryDirectory();
      String imageId = IdGenerator.generateUniqueId();

      // Compress the image; resulting type will be File
      File? compressedFile;
      if (isPhoto) {
        String targetPath = '${directory.path}/compressed_$imageId.jpg';

        compressedFile = await AssetServices.compressImage(asset, targetPath);
      }

      // Create a unique reference for the file
      Reference ref = firebaseStorage.ref().child(reference).child(imageId);

      // Upload the compressed image to Firebase Storage
      UploadTask task = ref.putFile(compressedFile ?? asset);
      String? downLURl;
      await task.whenComplete(() async {
        var downloadUrl = await ref.getDownloadURL();
        await compressedFile?.delete();
        downLURl = downloadUrl;
      });
      return downLURl;
    } catch (e) {
      throw Exception('Error uploading asset: ${e.toString()}');
    }
  }
}

class AssetStorageItems {
  final List<String> urls;
  final String? url;
  final String? extra;
  final bool isPhoto;

  AssetStorageItems({
    this.urls = const [],
    this.url,
    this.extra,
    this.isPhoto = true,
  });

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
