import 'package:social_media_app/core/common/entities/status_entity.dart';
import 'package:social_media_app/features/create_status/domain/entities/all_status_entity.dart';
import 'package:social_media_app/features/create_status/domain/repository/status_repository.dart';

class GetMyStatusUseCase {
  final StatusRepository repository;

  const GetMyStatusUseCase({required this.repository});

  Stream< StatusEntity?> call(String uid) {
    return repository.getMyStatus(uid);
  }
}
