import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/notification/domain/entities/customnotifcation.dart';
import 'package:social_media_app/features/notification/domain/usecases/create_notification_use_case.dart';
import 'package:social_media_app/features/notification/domain/usecases/delete_my_notification.dart';
import 'package:social_media_app/features/notification/domain/usecases/delete_notification.dart';
import 'package:social_media_app/features/notification/domain/usecases/get_my_notification.dart';

import '../../../../../settings/domain/entity/ui_entity/enums.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final CreateNotificationUseCase _createNotificationUseCase;
  final DeleteNotificationUseCase _deleteNotificationUseCase;
  final GetMyNotificationUseCase _getMyNotificationUseCase;
  final DeleteMyNotificationUseCase _deleteMyNotificationUseCase;
  NotificationCubit(
      this._createNotificationUseCase,
      this._deleteNotificationUseCase,
      this._getMyNotificationUseCase,
      this._deleteMyNotificationUseCase)
      : super(NotificationInitial());
  Future<void> createNotification(
      {required CustomNotification notification,
      required NotificationPreferenceEnum notificationPreferenceType}) async {
    final res = await _createNotificationUseCase(
        CreateNotificationUseCaseParams(
            notification: notification,
            notificationPreferenceType: notificationPreferenceType));
    res.fold((failure) => emit(NotificationFailed(failure.message)),
        (success) => emit(const NotificationCreated(notificationUid: '')));
  }

  Future<void> deleteNotification(
      {required NotificationCheck notificationCheck}) async {
    final res = await _deleteNotificationUseCase(
        DeleteNotificationUseCaseParams(notificationCheck: notificationCheck));
    res.fold((failure) => emit(NotificationFailed(failure.message)),
        (success) => emit(NotificationDeleted()));
  }

  Future<void> deleteMynotification(
      {required String myId, required String notificationId}) async {
    final res = await _deleteMyNotificationUseCase(
        DeleteMyNotificationUseCaseParams(
            notificationId: notificationId, myId: myId));
    res.fold(
        (failure) => emit(NotificationFailed(failure.message)), (success) {});
  }

  Future<void> getMynotifications({required String myId}) async {
    final streamRes = _getMyNotificationUseCase.call(myId);
    emit(NotificationLoading());

    await for (var value in streamRes) {
      value.fold((failure) {
        log('in the notificaton failure${failure.message}');
        emit(NotificationFailed(failure.message));
      }, (success) {
        emit(NotificationLoaded(notifications: success));
        log('in the cubit we got $success');
      });
    }
  }
}
