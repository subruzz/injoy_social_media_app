import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/notification/domain/entities/customnotifcation.dart';
import 'package:social_media_app/features/notification/domain/repository/notification_repository.dart';

import '../../../settings/domain/entity/ui_entity/enums.dart';

class CreateNotificationUseCase
    implements UseCase<Unit, CreateNotificationUseCaseParams> {
  final NotificationRepository _notificationRepository;

  CreateNotificationUseCase(
      {required NotificationRepository notificationRepository})
      : _notificationRepository = notificationRepository;
  @override
  Future<Either<Failure, Unit>> call(
      CreateNotificationUseCaseParams params) async {
    return await _notificationRepository.createNotification(
        notification: params.notification,
        notificationPreferenceType: params.notificationPreferenceType);
  }
}

class CreateNotificationUseCaseParams {
  final CustomNotification notification;
  final NotificationPreferenceEnum notificationPreferenceType;

  CreateNotificationUseCaseParams(
      {required this.notification, required this.notificationPreferenceType});
}
