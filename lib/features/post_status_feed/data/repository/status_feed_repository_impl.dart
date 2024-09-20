import 'package:cloud_firestore_platform_interface/src/timestamp.dart';
import 'package:fpdart/src/either.dart';
import 'package:social_media_app/core/common/entities/single_status_entity.dart';
import 'package:social_media_app/core/common/entities/status_entity.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/utils/errors/exception.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/features/post_status_feed/data/datasource/status_feed_remote_datasource.dart';
import 'package:social_media_app/features/post_status_feed/domain/repositories/status_feed_repository.dart';

class StatusFeedRepositoryImpl implements StatusFeedRepository {
  final StatusFeedRemoteDatasource _statusFeedRemoteDatasource;

  StatusFeedRepositoryImpl(
      {required StatusFeedRemoteDatasource statusFeedRemoteDatasource})
      : _statusFeedRemoteDatasource = statusFeedRemoteDatasource;
  @override
  Stream<List<SingleStatusEntity>> getMyStatus(String uid) {
    return _statusFeedRemoteDatasource.getMyStatus(uid);
  }

  @override
  Stream<List<StatusEntity>> getStatuses(String uId) {
    return _statusFeedRemoteDatasource.getStatuses(uId);
  }

  @override
  Future<Either<Failure, List<(PartialUser, Timestamp)>>> getStatuseViewers(
      Map<String, Timestamp> viewersId) async {
    try {
      final res =
          await _statusFeedRemoteDatasource.getStatuseViewers(viewersId);
      return right(res);
    } on MainException catch (_) {
      return left(Failure());
    }
  }
}
