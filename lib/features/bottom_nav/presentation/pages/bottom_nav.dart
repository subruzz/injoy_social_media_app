import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import 'package:social_media_app/core/common/functions/firebase_helper.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_event.dart';
import 'package:social_media_app/features/bottom_nav/presentation/pages/chat_web.dart';
import 'package:social_media_app/features/bottom_nav/presentation/pages/videos_page_web.dart';
import 'package:social_media_app/features/bottom_nav/presentation/widgets/bottom_bar_items.dart';
import 'package:social_media_app/features/chat/presentation/pages/chat_main_tab_page.dart';
import 'package:social_media_app/features/explore/presentation/pages/explore_page_builder.dart';
import 'package:social_media_app/features/notification/presentation/pages/notification_page.dart';
import 'package:social_media_app/features/post_status_feed/presentation/pages/home.dart';
import 'package:social_media_app/features/reels/presentation/pages/video_page.dart';
import 'package:social_media_app/features/reels/presentation/bloc/reels/reels_cubit.dart';
import 'package:social_media_app/core/utils/di/init_dependecies.dart';
import '../../../../core/common/entities/user_entity.dart';
import '../../../../core/widgets/helpet_packages.dart/lazy_indexted_stack.dart';
import '../../../chat/presentation/cubits/chat/chat_cubit.dart';
import '../../../explore/presentation/blocs/explore_user/explore_user_cubit.dart';
import '../../../post_status_feed/presentation/bloc/following_post_feed/following_post_feed_bloc.dart';
import '../../../profile/presentation/pages/profile_page_wrapper.dart';
import '../../../post_status_feed/presentation/bloc/get_all_statsus/get_all_status_bloc.dart';
import '../../../post_status_feed/presentation/bloc/for_you_posts/get_my_status/get_my_status_bloc.dart';
import 'package:provider/single_child_widget.dart';
part '../../utils/bottom_nav_providers.dart';
part '../../utils/rive_ui_const.dart';

class BottonNavWithAnimatedIcons extends StatefulWidget {
  const BottonNavWithAnimatedIcons({super.key});

  @override
  State<BottonNavWithAnimatedIcons> createState() =>
      _BottonNavWithAnimatedIconsState();
}

class _BottonNavWithAnimatedIconsState extends State<BottonNavWithAnimatedIcons>
    with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        context
            .read<AppUserBloc>()
            .add(const UserOnlineStatusUpdate(status: true));
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
        context
            .read<AppUserBloc>()
            .add(const UserOnlineStatusUpdate(status: false));
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }

  List<Widget> _pages = [];

  @override
  void initState() {
    serviceLocator<FirebaseHelper>()
        .deleteUnWantedStatus(context.read<AppUserBloc>().appUser.id);

    WidgetsBinding.instance.addObserver(this);
    super.initState();
    _pages = getScreens();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    for (var controller in _controllers) {
      controller?.dispose();
    }

    super.dispose();
  }

  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    final user = context.read<AppUserBloc>().appUser;
    return PopScope(
      canPop: _currentPage == 0,
      onPopInvoked: (didPop) {
        if (!didPop) {
          setState(() {
            _currentPage = 0;
          });
        }
      },
      child: MultiBlocProvider(
        providers: _getBottomBarProviders(user),
        child: Scaffold(
            body: LazyIndexedStack(
              index: _currentPage,
              children: List.generate(5, (i) => _pages[i]),
            ),
            bottomNavigationBar: BottomBarItems(
                animateToIcon: (index) {
                  animateTheIcon(index);
                  setState(() {
                    _currentPage = index;
                  });
                },
                controllers: _controllers,
                riveIconInputs: _riveIconInputs,
                currentPage: _currentPage)),
      ),
    );
  }
}
