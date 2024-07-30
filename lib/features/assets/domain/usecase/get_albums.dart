// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';
import 'package:photo_manager/photo_manager.dart';

import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/assets/domain/repository/asset_repository.dart';

class LoadAlbumsUseCase
    implements UseCase<(List<AssetPathEntity>, bool hasPermission), LoadAlbumsUseCaseParams> {
  final AssetRepository repository;

  LoadAlbumsUseCase(this.repository);
  @override
  Future<Either<Failure,(List<AssetPathEntity>, bool hasPermission)>> call(
      LoadAlbumsUseCaseParams params) async {
    return await repository.fetchAlbums(type: params.type);
  }
}

class LoadAlbumsUseCaseParams {
  final RequestType type;
  LoadAlbumsUseCaseParams({required this.type});
}
