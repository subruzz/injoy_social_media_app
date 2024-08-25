import 'dart:developer';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/utils/responsive/responsive_helper.dart';
import 'package:social_media_app/core/widgets/messenger/messenger.dart';
import 'package:social_media_app/core/providers.dart';
import 'package:social_media_app/core/utils/routes/app_routes_config.dart';
import 'package:social_media_app/core/common/shared_providers/cubit/app_language/app_language_cubit.dart';
import 'package:social_media_app/core/theme/app_theme.dart';
import 'package:social_media_app/features/notification/data/datacource/local/locatl_notification.dart';
import 'package:social_media_app/features/notification/data/datacource/remote/device_notification.dart';
import 'package:social_media_app/firebase_options.dart';
import 'package:social_media_app/core/utils/di/init_dependecies.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.appAttest,
  );
  if (!kIsWeb) {
    Stripe.publishableKey = dotenv.env['STRIPE_PUBLISH_KEY']!;
    await Stripe.instance.applySettings();
    await LocatlNotification.initLocalNotification();
    DeviceNotification.deviceNotificationInit();
    FirebaseMessaging.onBackgroundMessage(firebaseBackgroundNotification);
  }
  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //   if (message.notification != null) {
  //     String payload = jsonEncode(message.data);

  //     log('taped message');
  //     Navigator.of(navigatorKey.currentState!.context).push(MaterialPageRoute(
  //       builder: (context) => OtherUserProfilePage(
  //           otherUserId: 'q0BZNmIL4IdfNMPb2FqYzqYYZb63', userName: 'subru'),
  //     )); // arguments: message is NotificationResponse? );
  //   }
  // });
  //terminated

  // final RemoteMessage? message =
  //     await FirebaseMessaging.instance.getInitialMessage();

  // if (message != null) {
  //   Future.delayed(Duration.zero);
  // }

  await initDependencies();

  runApp(MyApp(navigatorKey: navigatorKey));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.navigatorKey});
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    _defineThePlatform(context);
    log(isThatTabOrDeskTop.toString());
    return ScreenUtilInit(
      designSize: Responsive.isDesktop(context)
          ? const Size(729, 1536)
          : const Size(360, 784),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiBlocProvider(
          providers: myProviders,
          child: Builder(builder: (ctx) {
            return BlocBuilder<AppLanguageCubit, AppLanguageState>(
              builder: (ctx, state) {
                return MaterialApp(
                  locale: state.locale,
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: const [
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
                );
              },
            );
          }),
        );
      },
    );
  }
}

_defineThePlatform(BuildContext context) {
  TargetPlatform platform = Theme.of(context).platform;
  double width = MediaQuery.of(context).size.width;

  // Determine screen size and platform
  isThatTabOrDeskTop = width >= 800;
  isThatTabAndMobile = width <= 1100;
  isThatTab = width >= 800 && width < 1100;
  isThatDeskTop = width >= 1100;
  isThatBtwMobAndTab = width >= 500 && width < 800;
  isThatMobile =
      platform == TargetPlatform.iOS || platform == TargetPlatform.android;
  isThatAndroid = platform == TargetPlatform.android;
}
