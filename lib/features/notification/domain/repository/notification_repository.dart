import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/notification/domain/entities/customnotifcation.dart';

abstract interface class NotificationRepository {
  Future<Either<Failure, Unit>> createNotification(
      {required CustomNotification notification});
  Future<Either<Failure, Unit>> deleteNotification(
      {required NotificationCheck notificationCheck});
  Stream<Either<Failure, List<CustomNotification>>> getMyNotifications(
      {required String myId});

  Future<Either<Failure, Unit>> deleteOneNotificationDirectly(
      {required String notificationId, required String myId});
}
