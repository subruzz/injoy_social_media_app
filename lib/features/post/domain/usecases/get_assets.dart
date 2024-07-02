// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';
import 'package:photo_manager/photo_manager.dart';

import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/usecases/usecase.dart';
import 'package:social_media_app/features/post/domain/repositories/asset_repository.dart';

class LoadAssetsUseCase
    implements UseCase<List<AssetEntity>, LoadAssetsUseCaseParams> {
  final AssetRepository repository;

  LoadAssetsUseCase(this.repository);
  @override
  Future<Either<Failure, List<AssetEntity>>> call(
      LoadAssetsUseCaseParams params) async {
    return await repository.loadAssets(params.selectedAlbum);
  }
}

class LoadAssetsUseCaseParams {
  final AssetPathEntity selectedAlbum;
  LoadAssetsUseCaseParams({
    required this.selectedAlbum,
  });
}
