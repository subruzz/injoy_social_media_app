import 'package:social_media_app/features/notification/domain/entities/customnotifcation.dart';

extension NotificationTypeExtension on NotificationType {
  static NotificationType fromShortString(String shortString) {
    switch (shortString) {
      case 'post':
        return NotificationType.post;
      case 'profile':
        return NotificationType.profile;
      case 'chat':
        return NotificationType.chat;
      default:
        throw StateError('No element matches $shortString');
    }
  }

  String toShortString() {
    return toString().split('.').last;
  }
}
