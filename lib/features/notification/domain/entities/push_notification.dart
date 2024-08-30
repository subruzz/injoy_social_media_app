import 'dart:convert';

import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';

import '../../../../core/common/models/post_model.dart';

class PushNotification {
  String body;
  String title;
  String deviceToken;
  final PostEntity? post;
  final PartialUser? user;
  PushNotification({
    required this.body,
    required this.title,
    required this.deviceToken,
    this.post,
    this.user,
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
            if (post != null) 'post': jsonEncode(post!.toJson()),
            if (user != null) 'user': jsonEncode(user!.toJson()),
          },
        }
      };
}
