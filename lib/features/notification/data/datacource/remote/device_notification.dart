import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/features/notification/data/datacource/local/locatl_notification.dart';
import 'package:social_media_app/features/notification/domain/entities/customnotifcation.dart';
import 'package:social_media_app/features/notification/domain/entities/push_notification.dart';
import 'package:social_media_app/main.dart';
import '../../../../../core/const/app_secrets/service.dart';
import '../../../../chat/presentation/pages/personal_chat_builder.dart';
import '../../../../explore/presentation/widgets/all_post_view.dart';
import '../../../../profile/presentation/pages/other_user_profile.dart';
import '../../../../reels/presentation/pages/video_page.dart';

class DeviceNotification {
  static final _firebaseMessaging = FirebaseMessaging.instance;

  static void requestPermission() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('permission available');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('only provisional');
    }
  }

  static void deviceNotificationInit() {
    //foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      String payload = jsonEncode(message.data);
      log('  palyload is ${message.data}');

      if (message.notification != null) {
        LocatlNotification.showNotification(
            message); // LocalNotificationService.showNotification(
        //     title: message.notification!.title ?? '',
        //     body: message.notification!.body ?? '',
        //     payload: payload);
      }
    });
  }

  static void tokenRefresh(String myId) {
    _firebaseMessaging.onTokenRefresh.listen((value) async {
      log('device token changed');
      FirebaseFirestore.instance
          .collection('users')
          .doc(myId)
          .update({'token': value});
    });
  }

  static Future<void> handleTerminatedNotification() async {
    final RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();

    if (message != null) {
      log('App opened from terminated state by a notification');
      Future.delayed(Duration.zero, () {
        handleNotificationNavigation(message.data);
      });
    }
  }

  static void handleNotificationNavigation(Map<String, dynamic> data) {
    if (data.containsKey('user')) {
      final userJson = data['user'];
      final Map<String, dynamic> userMap = jsonDecode(userJson);
      final user = PartialUser.fromJson(userMap);
      Navigator.of(navigatorKey.currentState!.context).push(
        MaterialPageRoute(
          builder: (context) => OtherUserProfilePage(user: user),
        ),
      );
    } else if (data.containsKey('post')) {
      final postJson = data['post'];
      final Map<String, dynamic> postMap = jsonDecode(postJson);
      final String? postId = postMap['postId'];
      final bool? isThatVdo = postMap['isThatVdo'];
      if (postId == null || isThatVdo == null) return;

      if (isThatVdo) {
        Navigator.of(navigatorKey.currentState!.context).push(
          MaterialPageRoute(
            builder: (context) => VideoReelPage(
              postId: postId,
              showOne: true,
            ),
          ),
        );
      } else {
        Navigator.of(navigatorKey.currentState!.context).push(
          MaterialPageRoute(
            builder: (context) => AllPostView(
              initialIndex: 0,
              postId: postId,
              showOnlyOne: true,
            ),
          ),
        );
      }
    } else if (data.containsKey('chatNotification')) {
      final postJson = data['chatNotification'];
      final Map<String, dynamic> postMap = jsonDecode(postJson);
      final String otherUserId = postMap['myId']; // Adjust key as necessary

      Navigator.of(navigatorKey.currentState!.context).push(
        MaterialPageRoute(
          builder: (context) => PersonalChatBuilder(otherUserId: otherUserId),
        ),
      );
    } else {
      log('Unknown notification type');
    }
  }

  static Future<String?> getAccessToken() async {
    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];
    http.Client client = await auth.clientViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceAccountSecret), scopes);
    //get access token
    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
            auth.ServiceAccountCredentials.fromJson(serviceAccountSecret),
            scopes,
            client);

    client.close();
    return credentials.accessToken.data;
  }

  static sendNotificationToUser(
      {required String deviceToken,
      required PartialUser? user,
      required CustomNotification notification,
      required ({
        String myId,
        String otherUserId,
      })? chatNotification,
      required ({
        String postId,
        String? commentId,
        bool isThatVdo
      })? post}) async {
    String notificationRoute;
    String routeParameterId;
    switch (notification.notificationType) {
      case NotificationType.chat:
        notificationRoute = "chat";
        routeParameterId = notification.uniqueId;
        break;
      case NotificationType.profile:
        notificationRoute = "profile";
        routeParameterId = notification.uniqueId;
        break;
      case NotificationType.post:
        notificationRoute = "post";
        routeParameterId = notification.uniqueId;
        break;
    }

    PushNotification detail = PushNotification(
        chatNotification: chatNotification,
        post: post,
        title: notification.senderName ?? "",
        body: notification.text,
        deviceToken: deviceToken,
        user: user);
    return await sendPopupNotification(notification: detail);
  }

  static Future<void> sendPopupNotification(
      {required PushNotification notification}) async {
    try {
      final String? serverAccessToken = await getAccessToken();
      if (serverAccessToken == null) return;
      String endpointFirebaseCloudMessaging =
          'https://fcm.googleapis.com/v1/projects/socialmediaapp-58c5c/messages:send';

      final http.Response response = await http.post(
        Uri.parse(endpointFirebaseCloudMessaging),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $serverAccessToken',
        },
        body: jsonEncode(notification.toMap()),
      );
      if (response.statusCode == 200) {
        log('success ');
      } else {
        log('error while sening notif${response.statusCode}');
      }
    } catch (e) {
      log('error while sening notif${e.toString()}');
    }
  }
}
