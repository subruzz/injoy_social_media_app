import 'package:equatable/equatable.dart';

class NotificationPreferences extends Equatable {
  bool isNotificationPaused;
  bool isMessageNotificationPaused;
  bool isCommentNotificationPaused;
  bool isLikeNotificationPaused;
  bool isFollowNotificationPaused;

  NotificationPreferences({
    this.isNotificationPaused = false,
    this.isFollowNotificationPaused = false,
    this.isMessageNotificationPaused = false,
    this.isCommentNotificationPaused = false,
    this.isLikeNotificationPaused = false,
  });

  @override
  List<Object?> get props => [
        isNotificationPaused,
        isMessageNotificationPaused,
        isFollowNotificationPaused,
        isCommentNotificationPaused,
        isLikeNotificationPaused,
      ];

  // Method to convert NotificationPreferences to a Map
  Map<String, dynamic> toMap() {
    return {
      'isFollowNotificationPaused': isFollowNotificationPaused,
      'isNotificationPaused': isNotificationPaused,
      'isMessageNotificationPaused': isMessageNotificationPaused,
      'isCommentNotificationPaused': isCommentNotificationPaused,
      'isLikeNotificationPaused': isLikeNotificationPaused,
    };
  }

  // Method to create NotificationPreferences from a Map
  factory NotificationPreferences.fromMap(Map<String, dynamic> map) {
    return NotificationPreferences(
      isFollowNotificationPaused: map['isFollowNotificationPaused'] ?? false,
      isNotificationPaused: map['isNotificationPaused'] ?? false,
      isMessageNotificationPaused: map['isMessageNotificationPaused'] ?? false,
      isCommentNotificationPaused: map['isCommentNotificationPaused'] ?? false,
      isLikeNotificationPaused: map['isLikeNotificationPaused'] ?? false,
    );
  }

  // CopyWith method to create a new instance with modified fields
  NotificationPreferences copyWith({
    bool? isNotificationPaused,
    bool? isMessageNotificationPaused,
    bool? isCommentNotificationPaused,
    bool? isLikeNotificationPaused,
    bool? isFollowNotificationPaused,
  }) {
    return NotificationPreferences(
      isNotificationPaused: isNotificationPaused ?? this.isNotificationPaused,
      isMessageNotificationPaused: isMessageNotificationPaused ?? this.isMessageNotificationPaused,
      isCommentNotificationPaused: isCommentNotificationPaused ?? this.isCommentNotificationPaused,
      isLikeNotificationPaused: isLikeNotificationPaused ?? this.isLikeNotificationPaused,
      isFollowNotificationPaused: isFollowNotificationPaused ?? this.isFollowNotificationPaused,
    );
  }
}
