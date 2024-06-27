
import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/status_entity.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/create_status/data/datasource/status_remote_datasource.dart';
import 'package:social_media_app/features/create_status/domain/repository/create_status_repository.dart';

class CreateStatusRepositoryImpl implements StatusRepository {
  final StatusRemoteDatasource _statusRemoteDatasource;

  CreateStatusRepositoryImpl(
      {required StatusRemoteDatasource statusRemoteDatasource})
      : _statusRemoteDatasource = statusRemoteDatasource;
      
        @override
        Future<Either<Failure, Unit>> createStatus(StatusEntity status) {
          // TODO: implement createStatus
          throw UnimplementedError();
        }
      
        @override
        Future<Either<Failure, Unit>> deleteStatus(StatusEntity status) {
          // TODO: implement deleteStatus
          throw UnimplementedError();
        }
      
        @override
        Stream<Either<Failure, List<StatusEntity>>> getMyStatus(String uid) {
          // TODO: implement getMyStatus
          throw UnimplementedError();
        }
      
        @override
        Future<Either<Failure, List<StatusEntity>>> getMyStatusFuture(String uid) {
          // TODO: implement getMyStatusFuture
          throw UnimplementedError();
        }
      
        @override
        Stream<Either<Failure, List<StatusEntity>>> getStatuses(StatusEntity status) {
          // TODO: implement getStatuses
          throw UnimplementedError();
        }
      
        @override
        Future<Either<Failure, Unit>> seenStatusUpdate(String statusId, int imageIndex, String userId) {
          // TODO: implement seenStatusUpdate
          throw UnimplementedError();
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
  
}
