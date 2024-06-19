import 'package:fpdart/fpdart.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/usecases/usecase.dart';
import 'package:social_media_app/features/create_post/domain/repositories/asset_repository.dart';

class LoadAssetsUseCase implements UseCase<List<AssetEntity>, NoParams> {
  final AssetRepository repository;

  LoadAssetsUseCase(this.repository);
  @override
  Future<Either<Failure, List<AssetEntity>>> call(NoParams params) async {
    return await repository.loadAssets();
  }
}
