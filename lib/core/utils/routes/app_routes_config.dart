import 'package:flutter/material.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/utils/routes/page_transitions.dart';

import 'package:social_media_app/core/utils/routes/tranistions/app_routes_const.dart';
import 'package:social_media_app/features/ai_chat/presentation/pages/ai_chat_page.dart';
import 'package:social_media_app/features/bottom_nav/presentation/pages/bottom_bar_builder.dart';
import 'package:social_media_app/features/media_picker/presenation/pages/custom_media_picker_page.dart';
import 'package:social_media_app/features/auth/presentation/pages/login_page.dart';
import 'package:social_media_app/features/auth/presentation/pages/signup_page.dart';
import 'package:social_media_app/features/bottom_nav/presentation/pages/bottom_nav.dart';
import 'package:social_media_app/core/services/assets/asset_model.dart';
import 'package:social_media_app/features/explore/presentation/pages/view_tag_or_location_posts.dart';
import 'package:social_media_app/features/location/presentation/pages/location_asking_page_builder.dart';
import 'package:social_media_app/features/notification/presentation/pages/cubit/notification_cubit/notification_cubit.dart';
import 'package:social_media_app/features/notification/presentation/pages/notification_page.dart';
import 'package:social_media_app/features/post/presentation/pages/create_post_page.dart';
import 'package:social_media_app/features/post_status_feed/presentation/pages/home.dart';
import 'package:social_media_app/features/premium_subscription/presentation/pages/premium_subscripti_builder.dart';
import 'package:social_media_app/features/premium_subscription/presentation/pages/premium_subscription_details_page.dart';
import 'package:social_media_app/features/profile/presentation/pages/add_profile_page.dart';
import 'package:social_media_app/features/profile/presentation/pages/date_of_birth_page.dart';
import 'package:social_media_app/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:social_media_app/features/profile/presentation/pages/interest_selection_page.dart';
import 'package:social_media_app/features/profile/presentation/pages/other_user_profile.dart';
import 'package:social_media_app/features/profile/presentation/pages/profile_loading.dart';
import 'package:social_media_app/features/settings/presentation/pages/account_settings_page.dart';
import 'package:social_media_app/features/settings/presentation/pages/chat_settings_page.dart';
import 'package:social_media_app/features/settings/presentation/pages/liked_or_saved_post_builder.dart';
import 'package:social_media_app/features/settings/presentation/pages/notification_preference_screen.dart';
import 'package:social_media_app/features/settings/presentation/pages/settings_actvity_page.dart';
import 'package:social_media_app/features/status/presentation/pages/create_mutliple_status_page.dart';
import 'package:social_media_app/features/status/presentation/pages/create_status_page.dart';
import 'package:social_media_app/features/status/presentation/pages/view_status_page.dart';
import 'package:social_media_app/features/who_visited_premium_feature/presentation/pages/user_visited_listing_page.dart';
import 'package:social_media_app/splash_screen.dart';

import '../../common/entities/single_status_entity.dart';
import '../../common/entities/status_entity.dart';
import '../../const/enums/media_picker_type.dart';

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
      // case MyAppRouteConst.usenameRoute:
      //   final String? userName = settings.arguments as String?;
      //   return MaterialPageRoute(
      //     builder: (_) => UsernameCheckPage(
      //       userid: ,
      //       userName: userName,
      //     ),
      //   );
      case MyAppRouteConst.dobPageRoute:
        final String? dob = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => DateOfBirthPage(
            dob: dob,
          ),
        );
      case MyAppRouteConst.bottomNavRoute:
        return MaterialPageRoute(builder: (_) => const BottomBarBuilder());

      case MyAppRouteConst.addProfilePage:
        return MaterialPageRoute(builder: (_) => AddProfilePage());

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

      // case MyAppRouteConst.viewPostsDetailedRoute:
      //   final PostEntity post = settings.arguments as PostEntity;
      //   return MaterialPageRoute(builder: (_) => ViewPost(post: post));

      case MyAppRouteConst.otherUserProfile:
        final Map<String, dynamic> params =
            settings.arguments as Map<String, dynamic>;
        final PartialUser user = params['user'];

        return AppPageTransitions.leftToRight(
          OtherUserProfilePage(user: user),
        );
      case MyAppRouteConst.notificationSettingsPage:
        return AppPageTransitions.rightToLeft(
            const NotificationPreferenceScreen());

      case MyAppRouteConst.notificationPage:
        final Map<String, dynamic> params =
            settings.arguments as Map<String, dynamic>;
        final NotificationCubit notificationCubit = params['notificationcubit'];
        return AppPageTransitions.rightToLeft(NotificationPage(
          notificationCubit: notificationCubit,
        ));
      case MyAppRouteConst.likedOrSavedPostsPage:
        final Map<String, dynamic>? params =
            settings.arguments as Map<String, dynamic>?;
        final bool isLiked = params?['isLiked'] ?? true;
        return AppPageTransitions.rightToLeft(
          LikedOrSavedPostBuilder(isLiked: isLiked),
        );

      case MyAppRouteConst.settingAndActivityPage:
        return AppPageTransitions.rightToLeft(const SettingsAndActivityPage());
      case MyAppRouteConst.editProfilePage:
        return AppPageTransitions.rightToLeft(const EditProfilePage());
      case MyAppRouteConst.aiChatPage:
        return AppPageTransitions.fade(const AiChatPage());
      case MyAppRouteConst.accountSettingsPage:
        final Map<String, dynamic> params =
            settings.arguments as Map<String, dynamic>;
        final String userId = params['userId'];
        return AppPageTransitions.rightToLeft(AccountSettingsPage(
          myId: userId,
        ));
      case MyAppRouteConst.premiumSubscriptionDetailsPage:
        return AppPageTransitions.rightToLeft(
            const PremiumSubscriptionDetailsPage());
      case MyAppRouteConst.premiumPage:
        return AppPageTransitions.rightToLeft(const PremiumSubscriptiBuilder());
      // case MyAppRouteConst.personaChatRoute:
      //   return MaterialPageRoute(builder: (_) => const PersonalChatBuilder());
      case MyAppRouteConst.userVisitedListingRoute:
        return AppPageTransitions.rightToLeft(const UserVisitedListingPage());
      case MyAppRouteConst.chatSettingPage:
        return AppPageTransitions.rightToLeft(const ChatSettingsPage());
      case MyAppRouteConst.statusCreationRoute:
        return AppPageTransitions.topToBottom(
          const StatusCreationPage(),
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
