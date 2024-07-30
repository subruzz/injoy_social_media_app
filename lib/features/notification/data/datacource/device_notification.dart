import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart ' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:social_media_app/features/notification/domain/entities/customnotifcation.dart';
import 'package:social_media_app/features/notification/domain/entities/push_notification.dart';

class DeviceNotification {
  static final _firebaseMessaging = FirebaseMessaging.instance;

  static Future<String?> getAccessToken() async {
    final serviceAccountJson = dotenv.env['SERVICE_ACCOUNT_JSON'];
    if (serviceAccountJson == null) return null;
    final serviceAccount = jsonDecode(serviceAccountJson);
    List<String> scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];
    http.Client client = await auth.clientViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceAccount), scopes);
    //get access token
    auth.AccessCredentials credentials =
        await auth.obtainAccessCredentialsViaServiceAccount(
            auth.ServiceAccountCredentials.fromJson(serviceAccount),
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
        notificationRoute = "profile";
        routeParameterId = notification.uniqueId;
        break;
    }

    PushNotification detail = PushNotification(
      title: notification.senderName,
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
        log('error while sening notif');
      }
    } catch (e) {
      log('error while sening notif${e.toString()}');
    }
  }
}
