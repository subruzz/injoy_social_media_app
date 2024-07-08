import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/const/messenger.dart';
import 'package:social_media_app/core/providers.dart';
import 'package:social_media_app/core/routes/app_routes_config.dart';
import 'package:social_media_app/core/theme/app_theme.dart';
import 'package:social_media_app/firebase_options.dart';
import 'package:social_media_app/init_dependecies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          child: MaterialApp.router(
            routerConfig: MyAppRouter.router,
            // routeInformationProvider:
            //     MyAppRouter.router.routeInformationProvider,
            // routeInformationParser: MyAppRouter.router.routeInformationParser,
            // routerDelegate: MyAppRouter.router.routerDelegate,
            scaffoldMessengerKey: Messenger.scaffoldKey,
            debugShowCheckedModeBanner: false,

            title: 'First Method',
            // You can use the library anywhere in the app even in theme
            theme: AppDarkTheme.darkTheme,
          ),
        );
      },
    );
  }
}
