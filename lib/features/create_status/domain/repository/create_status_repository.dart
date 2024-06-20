import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/status_entity.dart';
import 'package:social_media_app/core/errors/failure.dart';

abstract interface class CreateStatusRepository {
  Future<Either<Failure, Unit>> createStatus(
      StatusEntity status, File? statusImg);
  Future<Either<Failure, Unit>> updateStatus(
      StatusEntity status, File? statusImg);
  Future<Either<Failure, Unit>> deleteStatus(StatusEntity status);
}
