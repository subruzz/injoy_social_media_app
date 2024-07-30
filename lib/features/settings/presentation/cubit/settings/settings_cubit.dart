import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/settings/domain/entity/notification_preferences.dart';
import 'package:social_media_app/features/settings/domain/repository/settings_repository.dart';
import 'package:social_media_app/features/settings/domain/usecases/edit_notification_preference.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final EditNotificationPreferenceUseCase _editNotificationPreferenceUseCase;
  SettingsCubit(this._editNotificationPreferenceUseCase)
      : super(SettingsInitial());
  void editNotificationPreference(
      {required NotificationPreferences notificatonPreferernce,
      required NotificationPreferenceEnum notificationPreferenceType,
      required bool value,
      required String myid}) async {
    switch (notificationPreferenceType) {
      case NotificationPreferenceEnum.pauseAll:
        notificatonPreferernce.isNotificationPaused = value;
        break;
      case NotificationPreferenceEnum.likes:
        notificatonPreferernce.isLikeNotificationPaused = value;

        break;
      case NotificationPreferenceEnum.comments:
        notificatonPreferernce.isCommentNotificationPaused = value;

        break;
      case NotificationPreferenceEnum.follow:
        notificatonPreferernce.isFollowNotificationPaused = value;

        break;
      case NotificationPreferenceEnum.messages:
        notificatonPreferernce.isMessageNotificationPaused = value;

        break;
    }
    emit(NotifiationPreferenceLoading());
    final res = await _editNotificationPreferenceUseCase(
        EditNotificationPreferenceUseCaseParams(
            myId: myid, notificationPreferences: notificatonPreferernce));

    res.fold((failure) {
      switch (notificationPreferenceType) {
        case NotificationPreferenceEnum.pauseAll:
          notificatonPreferernce.isNotificationPaused =
              !notificatonPreferernce.isNotificationPaused;
          break;
        case NotificationPreferenceEnum.likes:
          notificatonPreferernce.isLikeNotificationPaused =
              !notificatonPreferernce.isLikeNotificationPaused;

          break;
        case NotificationPreferenceEnum.comments:
          notificatonPreferernce.isCommentNotificationPaused =
              !notificatonPreferernce.isCommentNotificationPaused;

          break;
        case NotificationPreferenceEnum.follow:
          notificatonPreferernce.isFollowNotificationPaused =
              !notificatonPreferernce.isFollowNotificationPaused;

          break;
        case NotificationPreferenceEnum.messages:
          notificatonPreferernce.isMessageNotificationPaused =
              !notificatonPreferernce.isMessageNotificationPaused;

          break;
      }
      emit(NotifiationPreferenceError(
        errorMsg: failure.message,
      ));
    }, (sucess) => emit(NotifiationPreferenceSuccess()));
  }
}
