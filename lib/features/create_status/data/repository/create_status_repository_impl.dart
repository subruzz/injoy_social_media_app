import 'dart:io';

import 'package:fpdart/src/either.dart';
import 'package:fpdart/src/unit.dart';
import 'package:social_media_app/core/common/entities/status_entity.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/create_status/data/datasource/status_remote_datasource.dart';
import 'package:social_media_app/features/create_status/domain/repository/create_status_repository.dart';

class CreateStatusRepositoryImpl implements CreateStatusRepository {
  final StatusRemoteDatasource _statusRemoteDatasource;

  CreateStatusRepositoryImpl(
      {required StatusRemoteDatasource statusRemoteDatasource})
      : _statusRemoteDatasource = statusRemoteDatasource;
  @override
  Future<Either<Failure, Unit>> createStatus(
      StatusEntity status, File? statusImg) async {
    try {
      await _statusRemoteDatasource.createStatus(status, statusImg);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteStatus(StatusEntity status) {
    // TODO: implement deleteStatus
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> updateStatus(
      StatusEntity status, File? statusImg) {
    // TODO: implement updateStatus
    throw UnimplementedError();
  }
}
