import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../../../core/common/entities/post.dart';
import '../../../../../core/common/models/partial_user_model.dart';
import '../../../../../main.dart';
import '../../../../profile/presentation/pages/other_user_profile.dart';
import '../../../../settings/presentation/pages/settings_actvity_page.dart';

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

  static void onNotificationTap(NotificationResponse response) {
    final payload = response.payload;
    if (payload != null && payload.isNotEmpty) {
      log('Foreground message tap, payload: $payload');

      try {
        final Map<String, dynamic> data = jsonDecode(payload);

        if (data.containsKey('user')) {
          // Decode the inner JSON string
          final userJson = data['user'];
          final Map<String, dynamic> userMap = jsonDecode(userJson);
          final user = PartialUser.fromJson(userMap);
          Navigator.of(navigatorKey.currentState!.context).push(
            MaterialPageRoute(
              builder: (context) => OtherUserProfilePage(user: user),
            ),
          );
        } else if (data.containsKey('post')) {
          // // Decode the inner JSON string
          // final postJson = data['post'];
          // final Map<String, dynamic> postMap = jsonDecode(postJson);
          // final post = PostEntity.fromJson(postMap);
          // Navigator.of(navigatorKey.currentState!.context).push(
          //   MaterialPageRoute(
          //     builder: (context) => PostDetailPage(post: post),
          //   ),
          // );
        } else {
          log('Unknown notification data');
        }
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
