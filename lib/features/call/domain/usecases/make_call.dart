import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/call/domain/entities/call_entity.dart';
import 'package:social_media_app/features/call/domain/repository/call_repository.dart';


class MakeCallUseCase implements UseCase<Unit, MakeCallUseCaseParams> {
  final CallRepository _callRepository;

  MakeCallUseCase({required CallRepository callRepository})
      : _callRepository = callRepository;

  @override
  Future<Either<Failure, Unit>> call(MakeCallUseCaseParams params) async {
    return await _callRepository.makeCall(params.call);
  }
}

class MakeCallUseCaseParams {
  final CallEntity call;

  MakeCallUseCaseParams({required this.call});
}
