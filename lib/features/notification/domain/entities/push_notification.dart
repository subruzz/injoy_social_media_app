import 'dart:convert';

import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';

class PushNotification {
  String body;
  String title;
  String deviceToken;
  final ({String postId, String? commentId, bool isThatVdo})? post;
  final PartialUser? user;
  final ({String myId, String otherUserId})? chatNotification;

  PushNotification({
    required this.body,
    required this.title,
    required this.chatNotification,
    required this.deviceToken,
    required this.post,
    required this.user,
  });

  Map<String, dynamic> toMap() => {
        'message': {
          'token': deviceToken,
          'notification': <String, dynamic>{
            'title': title,
            'body': body,
          },
          'android': {
            'notification': {'channel_id': '1'}
          },
          'data': <String, dynamic>{
            if (post != null)
              'post': jsonEncode({
                'isThatVdo': post!.isThatVdo,
                'postId': post!.postId,
                'openComment': post!.commentId,
              }),
            if (user != null) 'user': jsonEncode(user!.toJson()),
            if (chatNotification != null)
              'chatNotification': jsonEncode({
                'myId': chatNotification!.myId,
                'otherUserId': chatNotification!.otherUserId,
              }),
          },
        }
      };
}
