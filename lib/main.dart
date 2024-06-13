import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/bottom_nav.dart';
import 'package:social_media_app/core/bloc/app_user_bloc.dart';
import 'package:social_media_app/core/bloc/app_user_event.dart';
import 'package:social_media_app/core/const/messenger.dart';
import 'package:social_media_app/core/theme/app_theme.dart';
import 'package:social_media_app/features/auth/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:social_media_app/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:social_media_app/features/auth/presentation/bloc/google_auth/google_auth_bloc.dart';
import 'package:social_media_app/features/auth/presentation/bloc/signup_bloc/signup_bloc.dart';
import 'package:social_media_app/features/auth/presentation/pages/login_page.dart';
import 'package:social_media_app/features/auth/presentation/pages/signup_page.dart';
import 'package:social_media_app/features/home.dart';
import 'package:social_media_app/features/location/presentation/blocs/location_bloc/location_bloc.dart';
import 'package:social_media_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:social_media_app/features/profile/presentation/pages/add_profile_page.dart';
import 'package:social_media_app/features/profile/presentation/pages/profile_page.dart';

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
          providers: [
            BlocProvider(
              create: (context) => serviceLocator<SignupBloc>(),
            ),
            BlocProvider(
              create: (context) => serviceLocator<ProfileBloc>(),
            ),
            BlocProvider(
              create: (context) =>
                  serviceLocator<AppUserBloc>()..add(AppGetCurrentUser()),
            ),
            BlocProvider(
              create: (context) => serviceLocator<GoogleAuthBloc>(),
            ),
            BlocProvider(
              create: (context) => serviceLocator<LoginBloc>(),
            ),
            BlocProvider(
              create: (context) => serviceLocator<ForgotPasswordBloc>(),
            ),
            BlocProvider(
              create: (context) => serviceLocator<LocationBloc>(),
            )
          ],
          child: MaterialApp(
            scaffoldMessengerKey: Messenger.scaffoldKey,
            debugShowCheckedModeBanner: false,
            title: 'First Method',
            // You can use the library anywhere in the app even in theme
            theme: AppDarkTheme.darkTheme,
            home: BlocListener<AppUserBloc, AppUserState>(
              listener: (context, state) {
                if (state is UserModelNotFoundState) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                }
                if (state is AppUserLoggedIn) {
                  if (state.user.fullName == null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddProfilePage(
                          appUser: state.user,
                        ),
                      ),
                    );
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfilePage()));
                  }
                }
              },
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        );
      },
    );
  }
}
