// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';
import 'package:fpdart/src/either.dart';

import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/usecases/usecase.dart';
import 'package:social_media_app/features/create_status/domain/repository/status_repository.dart';

class DeleteStatuseCase implements UseCase<Unit, DeleteStatusUseCaseParams> {
  final StatusRepository _statusRepository;

  DeleteStatuseCase({required StatusRepository statusRepository})
      : _statusRepository = statusRepository;
  @override
  Future<Either<Failure, Unit>> call(params) async {
    return await _statusRepository.deleteStatus(params.sId, params.uId);
  }
}

class DeleteStatusUseCaseParams {
  final String sId;
  final String uId;
  DeleteStatusUseCaseParams({
    required this.sId,
    required this.uId,
  });
}
