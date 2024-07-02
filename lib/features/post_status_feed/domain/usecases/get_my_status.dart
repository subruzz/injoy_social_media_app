import 'package:social_media_app/core/common/entities/single_status_entity.dart';
import 'package:social_media_app/features/post_status_feed/domain/repositories/status_feed_repository.dart';

class GetMyStatusUseCase {
  final StatusFeedRepository repository;

  const GetMyStatusUseCase({required this.repository});

  Stream<List<SingleStatusEntity>> call(String uid) {
    return repository.getMyStatus(uid);
  }
}
