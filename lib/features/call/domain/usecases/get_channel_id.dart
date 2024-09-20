import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/call/domain/repository/call_repository.dart';

class GetAllChannelIdUseCase
    implements UseCase<String, GetAllChannelIdUseCaseParams> {
  final CallRepository _callRepository;

  GetAllChannelIdUseCase({required CallRepository callRepository})
      : _callRepository = callRepository;

  @override
  Future<Either<Failure, String>> call(
      GetAllChannelIdUseCaseParams params) async {
    return await _callRepository.getCallChannelId(params.uid);
  }
}

class GetAllChannelIdUseCaseParams {
  final String uid;

  GetAllChannelIdUseCaseParams({required this.uid});
}
