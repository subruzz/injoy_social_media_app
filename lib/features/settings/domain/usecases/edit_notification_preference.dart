import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/settings/domain/entity/notification_preferences.dart';
import 'package:social_media_app/features/settings/domain/repository/settings_repository.dart';

class EditNotificationPreferenceUseCase
    implements UseCase<Unit, EditNotificationPreferenceUseCaseParams> {
  final SettingsRepository _settingsRepository;

  EditNotificationPreferenceUseCase(
      {required SettingsRepository settingsRepository})
      : _settingsRepository = settingsRepository;

  @override
  Future<Either<Failure, Unit>> call(params) async {
    return await _settingsRepository.updateNotificationField(
        myId: params.myId,
        notificationPreference: params._notificationPreferences);
  }
}

class EditNotificationPreferenceUseCaseParams {
  final String myId;
  final NotificationPreferences _notificationPreferences;

  EditNotificationPreferenceUseCaseParams(
      {required this.myId,
      required NotificationPreferences notificationPreferences})
      : _notificationPreferences = notificationPreferences;
}
