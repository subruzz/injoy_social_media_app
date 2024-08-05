import 'dart:developer';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/notification/domain/entities/customnotifcation.dart';
import 'package:social_media_app/features/notification/domain/repository/notification_repository.dart';

import '../datacource/remote/notification_datasource.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationDatasource _notificationDatasource;

  NotificationRepositoryImpl(
      {required NotificationDatasource notificationDatasource})
      : _notificationDatasource = notificationDatasource;
  @override
  Future<Either<Failure, Unit>> createNotification(
      {required CustomNotification notification}) async {
    try {
      await _notificationDatasource.createNotification(
          notification: notification);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteNotification(
      {required NotificationCheck notificationCheck}) async {
    try {
      await _notificationDatasource.deleteNotification(
          notificationCheck: notificationCheck);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }

  @override
  Stream<Either<Failure, List<CustomNotification>>> getMyNotifications(
      {required String myId}) async* {
    try {
      await for (final notification
          in _notificationDatasource.getMyNotifications(myId: myId)) {
        log(notification.toString());
        yield Right(notification);
      }
    } on SocketException catch (e) {
      log(e.toString());
      yield Left(Failure(e.toString()));
    } catch (e) {
      log('error fom here ${e.toString()}');
      yield Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteOneNotificationDirectly(
      {required String notificationId, required String myId}) async {
    try {
      await _notificationDatasource.deleteOneNotificationDirectly(
          notificationId: notificationId, myId: myId);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }
}
