import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/utils/errors/exception.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/features/call/data/datasource/call_remote_datasource.dart';
import 'package:social_media_app/features/call/domain/entities/call_entity.dart';
import 'package:social_media_app/features/call/domain/repository/call_repository.dart';

class CallRepositoryImpl implements CallRepository {
  final CallRemoteDatasource _callRemoteDatasource;

  CallRepositoryImpl({required CallRemoteDatasource callRemoteDatasource})
      : _callRemoteDatasource = callRemoteDatasource;
  @override
  Future<Either<Failure, Unit>> endCall(
      String callerId, String recieverId) async {
    try {
      await _callRemoteDatasource.endCall(callerId, recieverId);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }

  @override
  Future<Either<Failure, String>> getCallChannelId(String uid) async {
    try {
      final res = await _callRemoteDatasource.getCallChannelId(uid);
      return right(res);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }

  @override
  Stream<Either<Failure, List<CallEntity>>> getUserCalling(String uid) async* {
    try {
      await for (final messages in _callRemoteDatasource.getUserCalling(uid)) {
        yield Right(messages);
      }
    } on SocketException catch (e) {
      yield Left(Failure(e.toString()));
    } catch (e) {
      yield Left(Failure());
    }
  }

  @override
  Future<Either<Failure, Unit>> makeCall(CallEntity call) async {
    try {
      await _callRemoteDatasource.makeCall(call);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveCallHistory(CallEntity call) async {
    try {
      await _callRemoteDatasource.saveCallHistory(call);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateCallHistoryStatus(CallEntity call) async {
    try {
      await _callRemoteDatasource.updateCallHistoryStatus(call);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }

  @override
  Stream<Either<Failure, List<CallEntity>>> getMyCallHistory(String uid) {
    // TODO: implement getMyCallHistory
    throw UnimplementedError();
  }
}
