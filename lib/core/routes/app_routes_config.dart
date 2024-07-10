import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/const/interest_list.dart';
import 'package:social_media_app/core/routes/app_routes_const.dart';
import 'package:social_media_app/features/assets/presenation/pages/custom_media_picker_page.dart';
import 'package:social_media_app/features/auth/presentation/pages/login_page.dart';
import 'package:social_media_app/features/auth/presentation/pages/signup_page.dart';
import 'package:social_media_app/features/bottom_nav/presentation/pages/bottom_nav.dart';
import 'package:social_media_app/features/location/presentation/pages/location_asking_page.dart';
import 'package:social_media_app/features/location/presentation/pages/location_asking_page_builder.dart';
import 'package:social_media_app/features/post/presentation/pages/create_post_page.dart';
import 'package:social_media_app/features/post_status_feed/presentation/pages/home.dart';
import 'package:social_media_app/features/profile/presentation/pages/add_profile/add_profile_page.dart';
import 'package:social_media_app/features/profile/presentation/pages/interest_page/interest_selection_page.dart';
import 'package:social_media_app/features/profile/presentation/pages/profile_loading.dart';
import 'package:social_media_app/splash_screen.dart';

class MyAppRouter {
  final bool isAuth;
  static GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        name: MyAppRouteConst.splashRote,
        path: '/',
        pageBuilder: (context, state) {
          return const MaterialPage(child: SplashScreen());
        },
      ),
      GoRoute(
        name: MyAppRouteConst.homeRoute,
        path: '/home',
        pageBuilder: (context, state) {
          return const MaterialPage(child: HomePage());
        },
      ),
      GoRoute(
        name: MyAppRouteConst.loginRoute,
        path: '/login',
        pageBuilder: (context, state) {
          return const MaterialPage(child: LoginPage());
        },
      ),
      GoRoute(
        name: MyAppRouteConst.signUpRoute,
        path: '/signup',
        pageBuilder: (context, state) {
          return const MaterialPage(child: SignupPage());
        },
      ),
      GoRoute(
        name: MyAppRouteConst.bottomNavRoute,
        path: '/bottom_nav',
        pageBuilder: (context, state) {
          return const MaterialPage(child: BottonNavWithAnimatedIcons());
        },
      ),
      GoRoute(
        name: MyAppRouteConst.addProfilePage,
        path: '/add_profile',
        pageBuilder: (context, state) {
          final AppUser appUser = state.extra as AppUser;
          return MaterialPage(child: AddProfilePage(appUser: appUser));
        },
      ),
      GoRoute(
        name: MyAppRouteConst.interestSelectRoute,
        path: '/interestSelect',
        pageBuilder: (context, state) {
          final List<String>? interest = state.extra as List<String>?;
          return MaterialPage(
              child: InterestSelectionPage(
            alreadySelectedInterests: interest,
          ));
        },
      ),
      GoRoute(
        name: MyAppRouteConst.locationPageRoute,
        path: '/locationPage',
        pageBuilder: (context, state) {
          return const MaterialPage(child: LocationAskingPageBuilder());
        },
      ),
      GoRoute(
        name: MyAppRouteConst.profileLoadingRouter,
        path: '/profileLoading',
        pageBuilder: (context, state) {
          return const MaterialPage(child: ProfileLoading());
        },
      ),
      GoRoute(
        name: MyAppRouteConst.mediaPickerRoute,
        path: '/media_picker_page',
        pageBuilder: (context, state) {
          final Map<String, dynamic>? extras =
              state.extra as Map<String, dynamic>?;
          final List<AssetEntity>? selectedAssets =
              extras?['selectedAssets'] as List<AssetEntity>?;
          final bool isPost = extras?['isPost'] as bool? ?? false;
          return MaterialPage(
            child: CustomMediaPickerPage(
              alreadySelected: selectedAssets,
              isPost: isPost,
            ),
          );
        },
      ),
      GoRoute(
        name: MyAppRouteConst.createPostRoute,
        path: '/create_post_page',
        pageBuilder: (context, state) {
          final List<AssetEntity> selectedAssets =
              state.extra as List<AssetEntity>;
          return MaterialPage(
              child: CreatePostScreen(selectedImages: selectedAssets));
        },
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      // final authState = context.read<AuthBloc>().state;
      // print('camer here');
      // if (authState is AuthNotLoggedIn) {
      //   print('logged');

      //   return context.namedLocation(MyAppRouteConst.loginRoute);
      // } else if (authState is AuthLoggedInOrUpdate) {
      //   print('logged');

      //   // Trigger your bloc events here
      //   context
      //       .read<GetAllStatusBloc>()     //       .add(GetAllstatusesEvent(uId: authState.user.id));
      //   context
      //       .read<GetMyStatusBloc>()
      //       .add(GetAllMystatusesEvent(uId: authState.user.id));
      //   context
      //       .read<FollowingPostFeedBloc>()
      //       .add(FollowingPostFeedGetEvent(uId: authState.user.id));
      //   context
      //       .read<GetUserPostsBloc>()
      //       .add(GetUserPostsrequestedEvent(uid: authState.user.id));

      //   return context.namedLocation(MyAppRouteConst.bottomNavRoute);
      // } else if (authState is AuthLoggedInButProfileNotSet) {
      //   print('logged');

      //   return context.namedLocation(MyAppRouteConst.addProfilePage);
      // }

      // return null; // No redirect if no conditions are met
    },
    errorPageBuilder: (context, state) => MaterialPage(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Page Not Found'),
        ),
      ),
    ),
  );

  MyAppRouter({required this.isAuth});
}
