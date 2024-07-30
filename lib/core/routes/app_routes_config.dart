import 'package:flutter/material.dart';
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
import 'package:social_media_app/features/status/presentation/pages/create_status_page.dart';
import 'package:social_media_app/features/status/presentation/pages/view_status_page.dart';
import 'package:social_media_app/features/who_visited_premium_feature/presentation/pages/user_visited_listing_page.dart';
import 'package:social_media_app/splash_screen.dart';

import '../common/entities/single_status_entity.dart';
import '../common/entities/status_entity.dart';

class MyAppRouter {
  final bool isAuth;

  MyAppRouter({required this.isAuth});

  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case MyAppRouteConst.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomePage());

      case MyAppRouteConst.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case MyAppRouteConst.signUpRoute:
        return MaterialPageRoute(builder: (_) => const SignupPage());

      case MyAppRouteConst.bottomNavRoute:
        return MaterialPageRoute(
            builder: (_) => const BottonNavWithAnimatedIcons());

      case MyAppRouteConst.addProfilePage:
        final AppUser appUser = settings.arguments as AppUser;
        return MaterialPageRoute(
            builder: (_) => AddProfilePage(appUser: appUser));

      case MyAppRouteConst.interestSelectRoute:
        final List<String>? interest = settings.arguments as List<String>?;
        return MaterialPageRoute(
          builder: (_) =>
              InterestSelectionPage(alreadySelectedInterests: interest),
        );

      case MyAppRouteConst.locationPageRoute:
        final bool isFirstTime = settings.arguments as bool? ?? false;
        return MaterialPageRoute(
          builder: (_) => LocationAskingPageBuilder(isFirstTime: isFirstTime),
        );

      case MyAppRouteConst.profileLoadingRouter:
        return MaterialPageRoute(builder: (_) => const AppLoadingGif());

      case MyAppRouteConst.mediaPickerRoute:
        final Map<String, dynamic>? extras =
            settings.arguments as Map<String, dynamic>?;
        final MediaPickerType pickerType =
            extras?['pickerType'] as MediaPickerType? ?? MediaPickerType.post;
        return MaterialPageRoute(
          builder: (_) => CustomMediaPickerPage(pickerType: pickerType),
        );

      case MyAppRouteConst.createMultipleStatusRoute:
        final Map<String, dynamic> params =
            settings.arguments as Map<String, dynamic>;
        final List<SelectedByte> selectedAssets = params['selectedAssets'];
        final bool isChat = params['isChat'];
        return MaterialPageRoute(
          builder: (_) =>
              CreateMutlipleStatusPage(assets: selectedAssets, isChat: isChat),
        );

      case MyAppRouteConst.createPostRoute:
        final List<SelectedByte> selectedAssets =
            settings.arguments as List<SelectedByte>;
        return MaterialPageRoute(
          builder: (_) => CreatePostScreen(selectedImages: selectedAssets),
        );

      case MyAppRouteConst.viewPostsDetailedRoute:
        final PostEntity post = settings.arguments as PostEntity;
        return MaterialPageRoute(builder: (_) => ViewPost(post: post));

      case MyAppRouteConst.otherUserProfile:
        final Map<String, dynamic> params =
            settings.arguments as Map<String, dynamic>;
        final String userName = params['userName'];
        final String otherUserId = params['otherUserId'];
        return MaterialPageRoute(
          builder: (_) => OtherUserProfilePage(
              userName: userName, otherUserId: otherUserId),
        );

      case MyAppRouteConst.hashtagPostsRoute:
        final Map<String, dynamic> params =
            settings.arguments as Map<String, dynamic>;
        final String hashTagName = params['hashTagName'];
        final int? hashTagPostCount = params['hashTagPostCount'];
        return MaterialPageRoute(
          builder: (_) => ViewHashTagPostsScreen(
              hashTagName: hashTagName, hashTagPostCount: hashTagPostCount),
        );

      case MyAppRouteConst.personaChatRoute:
        return MaterialPageRoute(builder: (_) => const PeronalChatBuilder());
      case MyAppRouteConst.userVisitedListingRoute:
        return MaterialPageRoute(
            builder: (_) => const UserVisitedListingPage());
      case MyAppRouteConst.statusCreationRoute:
        return MaterialPageRoute(
          builder: (_) => const StatusCreationPage(),
        );
      case MyAppRouteConst.viewStatusRoute:
        final Map<String, dynamic> params =
            settings.arguments as Map<String, dynamic>;
        final bool isMe = params['isMe'] ?? false;
        final int index = params['index'];
        final List<SingleStatusEntity>? myStatus = params['myStatuses'];

        final StatusEntity? statuses = params['statuses'];

        return MaterialPageRoute(
          builder: (_) => ViewStatusPage(
            index: index,
            isMe: isMe,
            myStatuses: myStatus,
            statusEntity: statuses,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(
              title: const Text('Page Not Found'),
            ),
          ),
        );
    }
  }
}
