import 'dart:async';
import 'dart:convert';
import 'dart:developer';

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

import 'package:social_media_app/core/common/shared_providers/cubit/connectivity_cubit.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
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
          log('Tapped message and payload is ${message.notification!.body.toString()}');
          DeviceNotification.handleNotificationNavigation(message.data);
        }
      });

      //terminated
    
      await initDependencies();

      runApp(MyApp(navigatorKey: navigatorKey));
    },
    (error, stackTrace) {},
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.navigatorKey});
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    _defineThePlatform(context);
    log(isThatTabOrDeskTop.toString());
    return ScreenUtilInit(
      designSize: !isThatMobile ? const Size(729, 1536) : const Size(360, 784),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiBlocProvider(
          providers: myProviders,
          child: Builder(builder: (ctx) {
            return BlocBuilder<AppLanguageCubit, AppLanguageState>(
              builder: (ctx, state) {
                return BlocListener<ConnectivityCubit, ConnectivityState>(
                  listener: (context, state) {
                    if (state is ConnectivityNotConnected) {
                      _showNoConnectionDialog();
                    } else {
                      _dismissNoConnectionDialog();
                    }
                  },
                  child: MaterialApp(
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
                      Locale('hi'), // Hindi
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
          }),
        );
      },
    );
  }

  void _dismissNoConnectionDialog() {
    if (navigatorKey.currentState?.canPop() ?? false) {
      navigatorKey.currentState?.pop();
    }
  }

  void _showNoConnectionDialog() {
    final context = navigatorKey.currentState?.overlay?.context;
    if (context != null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: const Text('No Connection'),
            content: const Text(
                'You are not connected to the internet.\nPlease connect to the internet to dismiss this dialogue'),
            actions: [
              TextButton(
                onPressed: () {},
                child: const Text('OK'),
              ),
            ],
          ),
        ),
      );
    }
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
      (platform == TargetPlatform.iOS || platform == TargetPlatform.android) &&
          !kIsWeb;
  isThatAndroid = platform == TargetPlatform.android;
}
