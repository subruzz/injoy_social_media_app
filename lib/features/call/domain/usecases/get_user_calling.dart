import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/features/call/domain/entities/call_entity.dart';
import 'package:social_media_app/features/call/domain/repository/call_repository.dart';

class GetUserCallingUseCase {
  final CallRepository _callRepository;

  GetUserCallingUseCase({required CallRepository callRepository})
      : _callRepository = callRepository;

  Stream<Either<Failure, List<CallEntity>>> call(String uId) {
    return _callRepository.getUserCalling(uId);
  }
}
