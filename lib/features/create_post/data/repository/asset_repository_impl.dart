import 'package:fpdart/fpdart.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/create_post/data/datasources/local/asset_local_source.dart';
import 'package:social_media_app/features/create_post/domain/repositories/asset_repository.dart';

class AssetRepositoryImpl implements AssetRepository {
  final AssetLocalSource _assetLocalSource;

  AssetRepositoryImpl({required AssetLocalSource assetLocalSource})
      : _assetLocalSource = assetLocalSource;

  @override
  Future<Either<Failure, List<AssetEntity>>> loadAssets(
    ) async {
    try {
      final assets = await _assetLocalSource.loadAssets();
      return right(assets);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg, e.details));
    }
  }
}
