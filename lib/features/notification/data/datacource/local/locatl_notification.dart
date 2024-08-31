import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:social_media_app/features/notification/data/datacource/remote/device_notification.dart';
import '../../../../../main.dart';
import '../../../../settings/presentation/pages/settings_actvity_page.dart';

@pragma('vm:entry-point')
Future<void> firebaseBackgroundNotification(RemoteMessage message) async {
  // String payload = jsonEncode(message.data);

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

  static void onNotificationTap(NotificationResponse response) {
    final payload = response.payload;
    if (payload != null && payload.isNotEmpty) {
      log('Foreground message tap, payload: $payload');
      try {
        final Map<String, dynamic> data = jsonDecode(payload);
        DeviceNotification.handleNotificationNavigation(data);
      } catch (e) {
        log('Error decoding payload: $e');
      }
    } else {
      log('No payload or empty payload received.');
    }
  }

  void _handleMessage(RemoteMessage message) async {
    Navigator.of(navigatorKey.currentState!.context).push(MaterialPageRoute(
        builder: (context) => SettingsAndActivityPage())); // a
  }

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
    final Map<String, dynamic> payload = message.data;

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        1,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
        payload: jsonEncode(payload),
      );
    });
  }
}
