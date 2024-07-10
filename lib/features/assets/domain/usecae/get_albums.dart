// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';
import 'package:photo_manager/photo_manager.dart';

import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/assets/domain/repository/asset_repository.dart';

class LoadAlbumsUseCase implements UseCase<List<AssetPathEntity>, NoParams> {
  final AssetRepository repository;

  LoadAlbumsUseCase(this.repository);
  @override
  Future<Either<Failure, List<AssetPathEntity>>> call(NoParams params) async {
    return await repository.fetchAlbums();
  }
}

class LoadAlbumsUseCaseParams {
  final AssetPathEntity selectedAlbum;
  LoadAlbumsUseCaseParams({
    required this.selectedAlbum,
  });
}
