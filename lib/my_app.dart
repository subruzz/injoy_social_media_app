import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/common/shared_providers/cubit/app_language/app_language_cubit.dart';
import 'package:social_media_app/core/theme/app_theme.dart';
import 'package:social_media_app/core/utils/extensions/localization.dart';
import 'package:social_media_app/core/widgets/messenger/messenger.dart';
import 'core/common/shared_providers/cubit/connectivity_cubit.dart';
import 'core/common/shared_providers/providers.dart';
import 'core/utils/responsive/constants.dart';
import 'core/utils/routes/app_routes_config.dart';
import 'core/widgets/dialog/no_internet_dialog.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.navigatorKey});
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Widget build(BuildContext context) {
    _defineThePlatform(context);
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
                      showNoConnectionDialog();
                    } else {
                      dismissNoConnectionDialog();
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
