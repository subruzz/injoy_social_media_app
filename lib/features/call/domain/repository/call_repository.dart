import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/call/domain/entities/call_entity.dart';

abstract interface class CallRepository {
  Future<Either<Failure, Unit>> makeCall(CallEntity call);
  Future<Either<Failure, Unit>> endCall(String callerId, String recieverId);
  Future<Either<Failure, Unit>> updateCallHistoryStatus(CallEntity call);

  Future<Either<Failure, Unit>> saveCallHistory(CallEntity call);
  Stream<Either<Failure, List<CallEntity>>> getUserCalling(String uid);
  Stream<Either<Failure, List<CallEntity>>> getMyCallHistory(String uid);
  Future<Either<Failure, String>> getCallChannelId(String uid);
}
