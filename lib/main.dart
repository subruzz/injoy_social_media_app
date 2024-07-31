  import 'dart:convert';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:social_media_app/core/const/messenger.dart';
import 'package:social_media_app/core/providers.dart';
import 'package:social_media_app/core/routes/app_routes_config.dart';
import 'package:social_media_app/core/theme/app_theme.dart';
import 'package:social_media_app/features/profile/presentation/pages/others_profile/other_user_profile.dart';
import 'package:social_media_app/firebase_options.dart';
import 'package:social_media_app/init_dependecies.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@pragma('vm:entry-point')
Future<void> firebaseBackgroundNotification(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // String payload = jsonEncode(message.data);

  // if (message.notification != null) {
  //   LocalNotificationService.showNotification(
  //       title: message.notification!.title ?? '',
  //       body: message.notification!.body ?? '',
  //       payload: payload);
  // }
  log('bckgournd notification came');
}

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Stripe.publishableKey = dotenv.env['STRIPE_PUBLISH_KEY']!;
  await Stripe.instance.applySettings();
  // await LocalNotificationService.localNotificationInit();
  FirebaseMessaging.onBackgroundMessage(firebaseBackgroundNotification);
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      String payload = jsonEncode(message.data);

      log('taped message');
      Navigator.of(navigatorKey.currentState!.context).push(MaterialPageRoute(
        builder: (context) => OtherUserProfilePage(
            otherUserId: 'q0BZNmIL4IdfNMPb2FqYzqYYZb63', userName: 'subru'),
      )); // arguments: message is NotificationResponse? );
    }
  });
  //terminated

  final RemoteMessage? message =
      await FirebaseMessaging.instance.getInitialMessage();

  if (message != null) {
    Future.delayed(Duration.zero);
  }

  //foreground
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payload = jsonEncode(message.data);
    log('payload is $payload');
    if (message.notification != null) {
      // LocalNotificationService.showNotification(
      //     title: message.notification!.title ?? '',
      //     body: message.notification!.body ?? '',
      //     payload: payload);
    }
    // Navigator.of(navigatorKey.currentState!.context).push(MaterialPageRoute(
    //   builder: (context) => OtherUserProfilePage(
    //       otherUserId: 'q0BZNmIL4IdfNMPb2FqYzqYYZb63', userName: 'subru'),
    // )); // a
  });
  await initDependencies();

  // /// 1.1.2: set navigator key to ZegoUIKitPrebuiltCallInvitationService
  // ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

  // // call the useSystemCallingUI
  // ZegoUIKit().initLog().then((value) {
  //   ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
  //     [ZegoUIKitSignalingPlugin()],
  //   );

  runApp(MyApp(navigatorKey: navigatorKey));
//   });
// }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.navigatorKey});
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    //Set the fit size (Find your UI design, look at the dimensions of the device screen and fill it in,unit in dp)
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MultiBlocProvider(
          providers: myProviders,
          child: MaterialApp(
            locale:const  Locale('ml'),
            localizationsDelegates:  const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales:const [
              Locale('en'), 
              Locale('ml'), 
            ],
            navigatorKey: navigatorKey,

            debugShowCheckedModeBanner: false,
            scaffoldMessengerKey: Messenger.scaffoldKey,
            onGenerateRoute: MyAppRouter(isAuth: false).generateRoute,
            initialRoute: '/',
            title: 'First Method',
            // You can use the library anywhere in the app even in theme
            theme: AppDarkTheme.darkTheme,
          ),
        );
      },
    );
  }
}
