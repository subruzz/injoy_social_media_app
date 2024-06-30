import 'package:fpdart/fpdart.dart';
import 'package:photo_manager/src/types/entity.dart';
import 'package:social_media_app/core/common/entities/status_entity.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/create_status/data/datasource/status_remote_datasource.dart';
import 'package:social_media_app/features/create_status/domain/entities/all_status_entity.dart';
import 'package:social_media_app/features/create_status/domain/entities/single_status_entity.dart';
import 'package:social_media_app/features/create_status/domain/repository/status_repository.dart';

class CreateStatusRepositoryImpl implements StatusRepository {
  final StatusRemoteDatasource _statusRemoteDatasource;

  CreateStatusRepositoryImpl(
      {required StatusRemoteDatasource statusRemoteDatasource})
      : _statusRemoteDatasource = statusRemoteDatasource;

  @override
  Future<Either<Failure, Unit>> createStatus(
      StatusEntity status, SingleStatusEntity singleStatus) async {
    try {
      await _statusRemoteDatasource.createStatus(status, singleStatus);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteStatus(
      String statusId, String uId) async {
    try {
      await _statusRemoteDatasource.deleteStatus(statusId, uId);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Stream<StatusEntity?> getMyStatus(String uid) {
    return _statusRemoteDatasource.getMyStatus(uid);
  }

  @override
  Future<Either<Failure, List<StatusEntity>>> getMyStatusFuture(String uid) {
    // TODO: implement getMyStatusFuture
    throw UnimplementedError();
  }

  @override
  Stream<List<StatusEntity>> getStatuses(String uId) {
    return _statusRemoteDatasource.getStatuses(uId);
  }

  @override
  Future<Either<Failure, Unit>> seenStatusUpdate(
      int index, String userId, String viewedUserId) async {
    try {
      await _statusRemoteDatasource.seenStatusUpdate(
          index, userId, viewedUserId);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateOnlyImageStatus(StatusEntity status) {
    // TODO: implement updateOnlyImageStatus
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> updateStatus(StatusEntity status) {
    // TODO: implement updateStatus
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> createMultipleStatus(StatusEntity status,
      List<String> caption, List<AssetEntity> assets) async {
    try {
      await _statusRemoteDatasource.createMultipleStatus(
          status, caption, assets);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }
}
