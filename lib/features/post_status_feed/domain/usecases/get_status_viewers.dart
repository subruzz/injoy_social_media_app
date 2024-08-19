import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/post_status_feed/domain/repositories/status_feed_repository.dart';

class GetStatusViewersUseCase
    implements
        UseCase<List<(PartialUser, Timestamp)>, GetStatusViewersUseCaseParams> {
  final StatusFeedRepository _statusFeedRepository;

  GetStatusViewersUseCase({required StatusFeedRepository statusFeedRepository})
      : _statusFeedRepository = statusFeedRepository;

  @override
  Future<Either<Failure, List<(PartialUser, Timestamp)>>> call(
      GetStatusViewersUseCaseParams params) async {
    return await _statusFeedRepository.getStatuseViewers(params.viewersMap);
  }
}

class GetStatusViewersUseCaseParams {
  final Map<String, Timestamp> viewersMap;

  GetStatusViewersUseCaseParams({required this.viewersMap});
}
