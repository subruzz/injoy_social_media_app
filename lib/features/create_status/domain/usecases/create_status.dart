import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/status_entity.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/usecases/usecase.dart';
import 'package:social_media_app/features/create_status/domain/repository/create_status_repository.dart';

class CreateStatusUseCase implements UseCase<Unit, CreateStatusUseCaseParams> {
  final CreateStatusRepository _createStatusRepository;

  CreateStatusUseCase({required CreateStatusRepository createStatusRepository})
      : _createStatusRepository = createStatusRepository;
  @override
  Future<Either<Failure, Unit>> call(CreateStatusUseCaseParams params) async {
    return await _createStatusRepository.createStatus(
        params.status, params.statusImage);
  }
}

class CreateStatusUseCaseParams {
  final StatusEntity status;
  final File? statusImage;

  CreateStatusUseCaseParams({required this.status, required this.statusImage});
}
