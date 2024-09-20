import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';

import 'package:social_media_app/features/call/domain/repository/call_repository.dart';

class EndCallUseCase implements UseCase<Unit, EndCallUseCaseParams> {
  final CallRepository _callRepository;

  EndCallUseCase({required CallRepository callRepository})
      : _callRepository = callRepository;

  @override
  Future<Either<Failure, Unit>> call(EndCallUseCaseParams params) async {
    return await _callRepository.endCall(params.callerId,params.recieverId);
  }
}

class EndCallUseCaseParams {
  final String callerId;
  final String recieverId;

  EndCallUseCaseParams({required this.callerId, required this.recieverId});

 
}
