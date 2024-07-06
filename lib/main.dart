import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/routes/app_routes_config.dart';
import 'package:social_media_app/core/shared_providers/blocs/initial_setup/initial_setup_cubit.dart';
import 'package:social_media_app/core/shared_providers/cubits/Pick_multiple_image/pick_multiple_image_cubit.dart';
import 'package:social_media_app/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:social_media_app/features/bottom_nav/presentation/cubit/bottom_nav_cubit.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/const/messenger.dart';
import 'package:social_media_app/core/theme/app_theme.dart';
import 'package:social_media_app/features/auth/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:social_media_app/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:social_media_app/features/auth/presentation/bloc/google_auth/google_auth_bloc.dart';
import 'package:social_media_app/features/auth/presentation/bloc/signup_bloc/signup_bloc.dart';
import 'package:social_media_app/features/post/presentation/bloc/album_bloc/album_bloc.dart';
import 'package:social_media_app/features/post/presentation/bloc/assets_bloc/assets_bloc.dart';
import 'package:social_media_app/features/post/presentation/bloc/create_post/create_post_bloc.dart';
import 'package:social_media_app/features/post/presentation/bloc/delte_post/delete_post_bloc.dart';
import 'package:social_media_app/features/post/presentation/bloc/like_post/like_post_bloc.dart';
import 'package:social_media_app/features/post/presentation/bloc/search_hashtag/search_hashtag_bloc.dart';
import 'package:social_media_app/features/post/presentation/bloc/update_post/update_post_bloc.dart';
import 'package:social_media_app/features/profile/presentation/bloc/add_interests/select_interest_cubit.dart';
import 'package:social_media_app/features/status/presentation/bloc/delete_status/delete_status_bloc.dart';
import 'package:social_media_app/features/status/presentation/bloc/get_all_statsus/get_all_status_bloc.dart';
import 'package:social_media_app/features/status/presentation/bloc/get_my_status/get_my_status_bloc.dart';
import 'package:social_media_app/features/status/presentation/bloc/status_bloc/status_bloc.dart';
import 'package:social_media_app/features/post_status_feed/presentation/bloc/following_post_feed/following_post_feed_bloc.dart';
import 'package:social_media_app/features/profile/presentation/bloc/get_user_posts_bloc/get_user_posts_bloc.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile_bloc/profile_bloc.dart';

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
              create: (context) => serviceLocator<DeleteStatusBloc>(),
            ),
            BlocProvider(
              create: (context) => serviceLocator<ProfileBloc>(),
            ),
            BlocProvider(
              create: (context) => serviceLocator<AppUserBloc>(),
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
              create: (context) => BottomNavCubit(),
            ),
            BlocProvider(
              create: (context) => serviceLocator<SearchHashtagBloc>(),
            ),
            BlocProvider(
              create: (context) => serviceLocator<CreatePostBloc>(),
            ),
            BlocProvider(
              create: (context) => serviceLocator<GetUserPostsBloc>(),
            ),
            BlocProvider(
              create: (context) => serviceLocator<FollowingPostFeedBloc>(),
            ),
            BlocProvider(
              create: (context) => serviceLocator<StatusBloc>(),
            ),
            BlocProvider(
              create: (context) => serviceLocator<SelectInterestCubit>(),
            ),
            BlocProvider(
              create: (context) =>
                  serviceLocator<AuthBloc>()..add(AuthCurrentUser()),
            ),
            BlocProvider(
              create: (context) => serviceLocator<UpdatePostBloc>(),
            ),
            BlocProvider(
              create: (context) => serviceLocator<DeletePostBloc>(),
            ),
            BlocProvider(
              create: (context) => serviceLocator<PickMultipleImageCubit>(),
            ),
            BlocProvider(
              create: (context) => serviceLocator<SearchHashtagBloc>(),
            ),
            BlocProvider(
              create: (context) => serviceLocator<LikePostBloc>(),
            ),
            BlocProvider(
              create: (context) => serviceLocator<GetMyStatusBloc>(),
            ),
            BlocProvider(
              create: (context) => serviceLocator<GetMyStatusBloc>(),
            ),
            BlocProvider(
              create: (context) => serviceLocator<GetAllStatusBloc>(),
            ),
            BlocProvider(
                create: (context) =>
                    serviceLocator<AlbumBloc>()..add(GetAlbumsEvent())),
            BlocProvider(create: (context) => serviceLocator<AssetsBloc>()),
            BlocProvider(
                create: (context) => serviceLocator<InitialSetupCubit>()),
          ],
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
