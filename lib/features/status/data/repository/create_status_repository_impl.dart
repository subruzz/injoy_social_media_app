import 'dart:typed_data';

import 'package:fpdart/fpdart.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/core/common/entities/status_entity.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/services/assets/asset_model.dart';
import 'package:social_media_app/features/status/data/datasource/status_remote_datasource.dart';
import 'package:social_media_app/core/common/entities/single_status_entity.dart';
import 'package:social_media_app/features/status/domain/repository/status_repository.dart';

class CreateStatusRepositoryImpl implements StatusRepository {
  final StatusRemoteDatasource _statusRemoteDatasource;

  CreateStatusRepositoryImpl(
      {required StatusRemoteDatasource statusRemoteDatasource})
      : _statusRemoteDatasource = statusRemoteDatasource;

  @override
  Future<Either<Failure, Unit>> createStatus(
      SingleStatusEntity singleStatus) async {
    try {
      await _statusRemoteDatasource.createStatus(singleStatus);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg, e.details));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteStatus(
      String statusId, String? imgUrl) async {
    try {
      await _statusRemoteDatasource.deleteStatus(statusId, imgUrl);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg, e.details));
    }
  }

  @override
  Future<Either<Failure, Unit>> seenStatusUpdate(
      String statusId, String viewedUserId) async {
    try {
      await _statusRemoteDatasource.seenStatusUpdate(statusId, viewedUserId);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg, e.details));
    }
  }

  @override
  Future<Either<Failure, Unit>> createMultipleStatus(
      List<SingleStatusEntity> statuses, List<SelectedByte> assets) async {
    try {
      await _statusRemoteDatasource.createMultipleStatus(statuses, assets);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg, e.details));
    }
  }
}
