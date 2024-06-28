// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/usecases/usecase.dart';
import 'package:social_media_app/features/create_status/domain/repository/status_repository.dart';

class SeeenStatusUpdateUseCase
    implements UseCase<Unit, SeeenStatusUpdateUseCaseParams> {
  final StatusRepository _statusRepository;

  SeeenStatusUpdateUseCase({required StatusRepository statusRepository})
      : _statusRepository = statusRepository;
  @override
  Future<Either<Failure, Unit>> call(
      SeeenStatusUpdateUseCaseParams params) async {
    return await _statusRepository.seenStatusUpdate(
        params.index, params.uId, params.viewedUid);
  }
}

class SeeenStatusUpdateUseCaseParams {
  final String uId;
  final int index;
  final String viewedUid;
  SeeenStatusUpdateUseCaseParams({
    required this.uId,
    required this.index,
    required this.viewedUid,
  });
}
