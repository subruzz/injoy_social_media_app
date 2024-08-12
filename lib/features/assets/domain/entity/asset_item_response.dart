import 'package:photo_manager/photo_manager.dart';

class AssetItemResponse {
  final List<AssetEntity> assets;
  final bool hasMore;

  AssetItemResponse({required this.assets, required this.hasMore});
}
