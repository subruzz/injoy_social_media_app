import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/utils/errors/exception.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/features/settings/data/datasource/settings_datasource.dart';
import 'package:social_media_app/features/settings/domain/entity/notification_preferences.dart';
import 'package:social_media_app/features/settings/domain/repository/settings_repository.dart';

class SettingRepoImpl implements SettingsRepository {
  final SettingsDatasource _settingsDatasource;

  SettingRepoImpl({required SettingsDatasource settingsDatasource})
      : _settingsDatasource = settingsDatasource;

  @override
  Future<Either<Failure, Unit>> updateNotificationField(
      {required String myId,
      required NotificationPreferences notificationPreference}) async {
    try {
      await _settingsDatasource.updateNotificationField(
          myId: myId, notificationPreference: notificationPreference);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }

  @override
  Future<Either<Failure, Unit>> clearAllChats(String myId) async {
    try {
      await _settingsDatasource.clearAllChats(myId);
      return right(unit);
    } catch (e) {
      return left(Failure());
    }
  }
}
