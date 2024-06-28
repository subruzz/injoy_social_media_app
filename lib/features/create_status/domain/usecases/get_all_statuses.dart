


import 'package:social_media_app/core/common/entities/status_entity.dart';
import 'package:social_media_app/features/create_status/domain/entities/all_status_entity.dart';
import 'package:social_media_app/features/create_status/domain/repository/status_repository.dart';

class GetAllStatusesUseCase {

  final StatusRepository repository;

  const GetAllStatusesUseCase({required this.repository});

  Stream<List<StatusEntity>> call(String uId) {
    return repository.getStatuses(uId);
  }
}