// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/notification/domain/entities/customnotifcation.dart';
import 'package:social_media_app/features/notification/domain/repository/notification_repository.dart';


class GetMyNotificationUseCase {
  final NotificationRepository _notificationRepository;

  GetMyNotificationUseCase(
      {required NotificationRepository notificationRepository})
      : _notificationRepository = notificationRepository;

  Stream<Either<Failure, List<CustomNotification>>> call(String myId) {
    return _notificationRepository.getMyNotifications(myId: myId);
  }
}
