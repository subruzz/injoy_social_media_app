


import 'package:social_media_app/core/common/entities/status_entity.dart';
import 'package:social_media_app/features/post_status_feed/domain/repositories/status_feed_repository.dart';

class GetAllStatusesUseCase {

  final StatusFeedRepository repository;

  const GetAllStatusesUseCase({required this.repository});

  Stream<List<StatusEntity>> call(String uId) {
    return repository.getStatuses(uId);
  }
}