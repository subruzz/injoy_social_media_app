import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/notification/domain/entities/customnotifcation.dart';
import 'package:social_media_app/features/notification/domain/repository/notification_repository.dart';

class DeleteNotificationUseCase
    implements UseCase<Unit, DeleteNotificationUseCaseParams> {
  final NotificationRepository _notificationRepository;

  DeleteNotificationUseCase(
      {required NotificationRepository notificationRepository})
      : _notificationRepository = notificationRepository;
  @override
  Future<Either<Failure, Unit>> call(
      DeleteNotificationUseCaseParams params) async {
    return await _notificationRepository.deleteNotification(
        notificationCheck: params.notificationCheck);
  }
}

class DeleteNotificationUseCaseParams {
  final NotificationCheck notificationCheck;

  DeleteNotificationUseCaseParams({required this.notificationCheck});
}
