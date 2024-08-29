import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart ' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:social_media_app/features/notification/data/datacource/local/locatl_notification.dart';
import 'package:social_media_app/features/notification/domain/entities/customnotifcation.dart';
import 'package:social_media_app/features/notification/domain/entities/push_notification.dart';

import '../../../../../core/const/app_secrets/service.dart';

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
      log('payload is $payload');
      if (message.notification != null) {
        LocatlNotification.showNotification(
            message); // LocalNotificationService.showNotification(
        //     title: message.notification!.title ?? '',
        //     body: message.notification!.body ?? '',
        //     payload: payload);
      }
      // Navigator.of(navigatorKey.currentState!.context).push(MaterialPageRoute(
      //   builder: (context) => OtherUserProfilePage(
      //       otherUserId: 'q0BZNmIL4IdfNMPb2FqYzqYYZb63', userName: 'subru'),
      // )); // a
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
      required CustomNotification notification}) async {
    String notificationRoute;
    String routeParameterId;
    switch (notification.notificationType) {
      case NotificationType.chat:
        notificationRoute = "chat";
        routeParameterId = notification.uniqueId;
        break;
      case NotificationType.profile:
        notificationRoute = "profile";
        routeParameterId = notification.uniqueId; // Handle follow notification
        break;
      case NotificationType.post:
        notificationRoute = "post";
        routeParameterId = notification.uniqueId;
        break;
    }

    PushNotification detail = PushNotification(
      title: notification.senderName ?? "",
      body: notification.text,
      deviceToken: deviceToken,
      notificationRoute: notificationRoute,
      routeParameterId: routeParameterId,

      /// to avoid errors
      userCallingId: notification.uniqueId,
    );
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
