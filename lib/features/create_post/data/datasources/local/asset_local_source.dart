import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/core/errors/exception.dart';

abstract class AssetLocalSource {
  Future<List<AssetEntity>> loadAssets();
}

class AssetLocalSourceImpl implements AssetLocalSource {
  @override
  Future<List<AssetEntity>> loadAssets() async {
    try {
      var permission = await PhotoManager.requestPermissionExtend();
      if (permission.isAuth) {
        final albums =
            await PhotoManager.getAssetPathList(type: RequestType.image);

        final List<AssetEntity> assets = [];
        for (var album in albums) {
          final asset = await album.getAssetListRange(
            start: 0,
            end: await album.assetCountAsync,
          );
          assets.addAll(asset);
        }

        return assets;
      } else {
        throw const MainException(
            errorMsg: 'Permission denied',
            details: 'Please enable permission and try again!');
      }
    } catch (e) {
      throw MainException(errorMsg: e.toString());
    }
  }
}
