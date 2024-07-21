import 'package:fpdart/fpdart.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/assets/domain/repository/asset_repository.dart';
import 'package:social_media_app/features/assets/data/datasource/asset_local_datasource.dart';

class AssetRepositoryImpl implements AssetRepository {
  final AssetLocalSource _assetLocalSource;

  AssetRepositoryImpl({required AssetLocalSource assetLocalSource})
      : _assetLocalSource = assetLocalSource;

  @override
  Future<Either<Failure, List<AssetEntity>>> loadAssets(
      AssetPathEntity selectedAlbum) async {
    try {
      final assets = await _assetLocalSource.loadAssets(selectedAlbum);
      return right(assets);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg, e.details));
    }
  }

  @override
  Future<Either<Failure, List<AssetPathEntity>>> fetchAlbums(
      {required RequestType type}) async {
    try {
      final assets = await _assetLocalSource.fetchAlbums(type);
      return right(assets);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg, e.details));
    }
  }
}
