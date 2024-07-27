import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/notification/domain/repository/notification_repository.dart';

class DeleteMyNotificationUseCase
    implements UseCase<Unit, DeleteMyNotificationUseCaseParams> {
  final NotificationRepository _notificationRepository;

  DeleteMyNotificationUseCase(
      {required NotificationRepository notificationRepository})
      : _notificationRepository = notificationRepository;
  @override
  Future<Either<Failure, Unit>> call(
      DeleteMyNotificationUseCaseParams params) async {
    return await _notificationRepository.deleteOneNotificationDirectly(
        notificationId: params.notificationId, myId: params.myId);
  }
}

class DeleteMyNotificationUseCaseParams {
  final String notificationId;
  final String myId;

  DeleteMyNotificationUseCaseParams(
      {required this.notificationId, required this.myId});
}
