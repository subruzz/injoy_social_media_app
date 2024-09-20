import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/call/domain/entities/call_entity.dart';
import 'package:social_media_app/features/call/domain/repository/call_repository.dart';

class SaveCallHistoryUseCase
    implements UseCase<Unit, SaveCallHistoryUseCaseParams> {
  final CallRepository _callRepository;

  SaveCallHistoryUseCase({required CallRepository callRepository})
      : _callRepository = callRepository;

  @override
  Future<Either<Failure, Unit>> call(
      SaveCallHistoryUseCaseParams params) async {
    return await _callRepository.saveCallHistory(params.call);
  }
}

class SaveCallHistoryUseCaseParams {
  final CallEntity call;

  SaveCallHistoryUseCaseParams({required this.call});
}
