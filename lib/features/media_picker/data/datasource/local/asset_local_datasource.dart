import 'package:flutter/foundation.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class AssetLocalSource {
  Future<List<AssetEntity>> loadAssets(AssetPathEntity selectedAlbum);
  Future<void> grantPermissions();
  Future<(List<AssetPathEntity>, bool hasPermission)> fetchAlbums(
      RequestType type);
}

class AssetLocalSourceImpl implements AssetLocalSource {
  @override
  Future<List<AssetEntity>> loadAssets(AssetPathEntity selectedAlbum) async {
    try {
      List<AssetEntity> assetList =
          await selectedAlbum.getAssetListPaged(page: 0, size: 30);
      return assetList;
      // await selectedAlbum.getAssetListRange(
      //     start: 0, end: await selectedAlbum.assetCountAsync);
    } catch (e) {
      throw MainException(errorMsg: e.toString());
    }
  }

  @override
  Future<(List<AssetPathEntity>, bool hasPermission)> fetchAlbums(
      RequestType type) async {
    List<AssetPathEntity> albums = [];

    try {
      final isEnabled = await grantPermissions();
      if (!isEnabled) {
        return (albums, false);
      }
      final FilterOptionGroup filterOption = FilterOptionGroup(
        imageOption: const FilterOption(
          sizeConstraint: SizeConstraint(
            maxWidth: 10000,
            maxHeight: 10000,
            minWidth: 100,
            minHeight: 100,
            ignoreSize: false,
          ),
        ),
        videoOption: const FilterOption(
          durationConstraint: DurationConstraint(
            max: Duration(seconds: 60),
            allowNullable: false,
          ),
        ),
      );
      albums = await PhotoManager.getAssetPathList(
       type: type, filterOption: filterOption);
      return (albums, true);
    } catch (e) {
      throw const MainException(
          errorMsg: 'An unexpected error occured during fetching media');
    }
  }

  @override
  Future<bool> grantPermissions() async {
    try {
      // Check if permissions are already granted
      final bool videosGranted = await Permission.videos.isGranted;
      final bool photosGranted = await Permission.photos.isGranted;

      // If both permissions are granted, return true
      if (photosGranted && videosGranted) {
        return true;
      }

      // Request permissions if not granted
      final Map<Permission, PermissionStatus> statuses = await [
        Permission.videos,
        Permission.photos,
      ].request();

      // Check the status of each permission
      final bool videosGrantedNow =
          statuses[Permission.videos] == PermissionStatus.granted;
      final bool photosGrantedNow =
          statuses[Permission.photos] == PermissionStatus.granted;

      // If either permission is permanently denied, open app settings
      if (statuses[Permission.videos] == PermissionStatus.permanentlyDenied ||
          statuses[Permission.photos] == PermissionStatus.permanentlyDenied) {
        await openAppSettings();
      }

      // Return true if both permissions are granted now
      return videosGrantedNow && photosGrantedNow;
    } catch (e) {
      // Handle any exceptions that occur during permission handling
      debugPrint('Error granting permissions: $e');
      return false;
    }
  }
}
