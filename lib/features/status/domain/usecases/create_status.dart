import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/status_entity.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/usecases/usecase.dart';
import 'package:social_media_app/core/common/entities/single_status_entity.dart';
import 'package:social_media_app/features/status/domain/repository/status_repository.dart';

class CreateStatusUseCase implements UseCase<Unit, CreateStatusUseCaseParams> {
  final StatusRepository _statusRepository;

  CreateStatusUseCase({required StatusRepository createStatusRepository})
      : _statusRepository = createStatusRepository;
  @override
  Future<Either<Failure, Unit>> call(CreateStatusUseCaseParams params) async {
    return await _statusRepository.createStatus(
      params.singleStatus);
  }
}

class CreateStatusUseCaseParams {

  final File? statusImage;
  final SingleStatusEntity singleStatus;
  CreateStatusUseCaseParams({
    required this.singleStatus,
    this.statusImage,
  });
}
