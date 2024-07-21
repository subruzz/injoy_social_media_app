
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/routes/app_routes_const.dart';
import 'package:social_media_app/features/assets/presenation/pages/custom_media_picker_page.dart';
import 'package:social_media_app/features/auth/presentation/pages/login_page.dart';
import 'package:social_media_app/features/auth/presentation/pages/signup_page.dart';
import 'package:social_media_app/features/bottom_nav/presentation/pages/bottom_nav.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/peronal_chat_builder.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/utils.dart';
import 'package:social_media_app/features/explore/presentation/pages/view_hash_tag_posts.dart';
import 'package:social_media_app/features/location/presentation/pages/location_asking_page_builder.dart';
import 'package:social_media_app/features/post/presentation/pages/create_post_page.dart';
import 'package:social_media_app/features/post/presentation/pages/view_post.dart';
import 'package:social_media_app/features/post_status_feed/presentation/pages/home.dart';
import 'package:social_media_app/features/profile/presentation/pages/add_profile/add_profile_page.dart';
import 'package:social_media_app/features/profile/presentation/pages/interest_page/interest_selection_page.dart';
import 'package:social_media_app/features/profile/presentation/pages/others_profile/other_user_profile.dart';
import 'package:social_media_app/features/profile/presentation/pages/profile_loading.dart';
import 'package:social_media_app/features/status/presentation/pages/create_mutliple_status_page.dart';
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
          final bool isFirstTime = state.extra as bool? ?? false;
          return MaterialPage(
              child: LocationAskingPageBuilder(isFirstTime: isFirstTime));
        },
      ),
      GoRoute(
        name: MyAppRouteConst.profileLoadingRouter,
        path: '/profileLoading',
        pageBuilder: (context, state) {
          return const MaterialPage(child: AppLoadingGif());
        },
      ),
      GoRoute(
        name: MyAppRouteConst.mediaPickerRoute,
        path: '/media_picker_page',
        pageBuilder: (context, state) {
          final Map<String, dynamic>? extras =
              state.extra as Map<String, dynamic>?;
          final MediaPickerType pickerType =
              extras?['pickerType'] as MediaPickerType? ?? MediaPickerType.post;

          return MaterialPage(
            child: CustomMediaPickerPage(
              pickerType: pickerType,
            ),
          );
        },
      ),
      GoRoute(
        name: MyAppRouteConst.createMultipleStatusRoute,
        path: '/create_multiple_status_page',
        pageBuilder: (context, state) {
          final Map<String, dynamic> params =
              state.extra as Map<String, dynamic>;
          final List<SelectedByte> selectedAssets = params['selectedAssets'];
          final bool isChat = params['isChat'];
          return MaterialPage(
              child: CreateMutlipleStatusPage(
                  assets: selectedAssets, isChat: isChat));
        },
      ),
      GoRoute(
        name: MyAppRouteConst.createPostRoute,
        path: '/create_post_page',
        pageBuilder: (context, state) {
          final List<SelectedByte> selectedAssets =
              state.extra as List<SelectedByte>;
          return MaterialPage(
              child: CreatePostScreen(selectedImages: selectedAssets));
        },
      ),
      GoRoute(
        name: MyAppRouteConst.viewPostsDetailedRoute,
        path: '/viewPostDetailsPage',
        pageBuilder: (context, state) {
          final PostEntity post = state.extra as PostEntity;
          return MaterialPage(child: ViewPost(post: post));
        },
      ),
      GoRoute(
        name: MyAppRouteConst.otherUserProfile,
        path: '/otherUserProfile',
        pageBuilder: (context, state) {
          final Map<String, dynamic> params =
              state.extra as Map<String, dynamic>;
          final String userName = params['userName'];
          final String otherUserId = params['otherUserId'];
          return MaterialPage(
            child: OtherUserProfilePage(
              userName: userName,
              otherUserId: otherUserId,
            ),
          );
        },
      ),
      GoRoute(
        name: MyAppRouteConst.hashtagPostsRoute,
        path: '/viewHashTagPosts',
        pageBuilder: (context, state) {
          final Map<String, dynamic> params =
              state.extra as Map<String, dynamic>;
          final String hashTagName = params['hashTagName'];
          final int? hashTagPostCount = params['hashTagPostCount'];
          return MaterialPage(
            child: ViewHashTagPostsScreen(
              hashTagName: hashTagName,
              hashTagPostCount: hashTagPostCount,
            ),
          );
        },
      ),
      GoRoute(
        name: MyAppRouteConst.personaChatRoute,
        path: '/personChatPage',
        pageBuilder: (context, state) {
          return const MaterialPage(child: PeronalChatBuilder());
        },
      ),
    ],
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
