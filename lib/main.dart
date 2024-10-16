import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:social_media_app/core/utils/di/di.dart';
import 'package:social_media_app/features/notification/data/datacource/local/locatl_notification.dart';
import 'package:social_media_app/features/notification/data/datacource/remote/device_notification.dart';
import 'package:social_media_app/firebase_options.dart';
import 'package:social_media_app/my_app.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
      // Bloc.observer = SimpleBlocObserver();

      await dotenv.load(fileName: '.env');
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      if (!kIsWeb) {
        Stripe.publishableKey = dotenv.env['STRIPE_PUBLISH_KEY']!;
        await Stripe.instance.applySettings();
        await LocatlNotification.initLocalNotification();
        DeviceNotification.deviceNotificationInit();
        FirebaseMessaging.onBackgroundMessage(firebaseBackgroundNotification);
      }
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        if (message.notification != null) {
          DeviceNotification.handleNotificationNavigation(message.data);
        }
      });
      await initDependencies();
      runApp(MyApp(navigatorKey: navigatorKey));
    },
    (error, stackTrace) {},
  );
}

