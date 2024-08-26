import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/settings/domain/entity/notification_preferences.dart';

abstract interface class SettingsRepository {
  Future<Either<Failure, Unit>> updateNotificationField(
      {required String myId,
      required NotificationPreferences notificationPreference});
  Future<Either<Failure, Unit>> clearAllChats(String myId);
}
