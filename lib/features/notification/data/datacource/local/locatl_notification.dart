import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> firebaseBackgroundNotification(RemoteMessage message) async {
  String payload = jsonEncode(message.data);

  // if (message.notification != null) {
  //   LocatlNotification.showNotification(message);
  // }
}

class LocatlNotification {
  const LocatlNotification._();
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static Future<void> initLocalNotification() async {
    const androidInitSettings =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    // const iosInitSettings = DarwinInitializationSettings();
    const initSettings = InitializationSettings(android: androidInitSettings);
    _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();
    await _flutterLocalNotificationsPlugin.initialize(initSettings,
        onDidReceiveBackgroundNotificationResponse: onNotificationTap,
        onDidReceiveNotificationResponse: onNotificationTap);
  }

  static void onNotificationTap(NotificationResponse response) {}
  static Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
        '1', 'Channel_name',
        importance: Importance.max);
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      message.notification!.body.toString(),
      htmlFormatBigText: true,
      contentTitle: message.notification!.title.toString(),
      htmlFormatContentTitle: true,
    );
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(channel.id, channel.name,
            channelDescription: 'desc',
            sound: const RawResourceAndroidNotificationSound('notification'),
            importance: Importance.high,
            styleInformation: bigTextStyleInformation,
            priority: Priority.high,
            ticker: 'ticker');
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
          1,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails);
    });
  }
}
