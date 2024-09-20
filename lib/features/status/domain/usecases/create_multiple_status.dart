import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/core/services/assets/asset_model.dart';
import 'package:social_media_app/features/status/domain/repository/status_repository.dart';

import '../../../../core/common/entities/single_status_entity.dart';

class CreateMultipleStatusUseCase
    implements UseCase<Unit, CreateMutlipleStatusUseCaseParams> {
  final StatusRepository _statusRepository;

  CreateMultipleStatusUseCase(
      {required StatusRepository createStatusRepository})
      : _statusRepository = createStatusRepository;
  @override
  Future<Either<Failure, Unit>> call(
      CreateMutlipleStatusUseCaseParams params) async {
    return await _statusRepository.createMultipleStatus(
        params.statuses, params.assets, );
  }
}

class CreateMutlipleStatusUseCaseParams {
  final List<SingleStatusEntity> statuses;
  final List<SelectedByte> assets;

  CreateMutlipleStatusUseCaseParams({required this.statuses, required this.assets});
}
