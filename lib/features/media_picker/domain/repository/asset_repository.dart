import 'package:fpdart/fpdart.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';

abstract class AssetRepository {
  Future<Either<Failure, List<AssetEntity>>> loadAssets(
      AssetPathEntity selectedAlbum);
  Future<Either<Failure, (List<AssetPathEntity>, bool hasPermission)>>
      fetchAlbums({required RequestType type});
}
