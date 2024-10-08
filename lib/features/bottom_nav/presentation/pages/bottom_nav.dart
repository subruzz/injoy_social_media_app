import 'dart:developer';

import 'package:provider/single_child_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import 'package:social_media_app/core/common/functions/firebase_helper.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_event.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/features/ai_chat/presentation/pages/ai_chat_page.dart';
import 'package:social_media_app/features/bottom_nav/presentation/cubit/bottom_bar_cubit.dart';
import 'package:social_media_app/features/bottom_nav/presentation/web/chat_web.dart';
import 'package:social_media_app/features/bottom_nav/presentation/widgets/bottom_bar_items.dart';
import 'package:social_media_app/features/chat/presentation/pages/chat_main_tab_page.dart';
import 'package:social_media_app/features/explore/presentation/pages/explore_page_builder.dart';
import 'package:social_media_app/features/notification/data/datacource/remote/device_notification.dart';
import 'package:social_media_app/features/post_status_feed/presentation/pages/home.dart';
import 'package:social_media_app/features/reels/presentation/pages/video_page.dart';
import 'package:social_media_app/features/reels/presentation/bloc/reels/reels_cubit.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/common/entities/user_entity.dart';
import '../../../../core/utils/di/di.dart';
import '../../../../core/utils/routes/tranistions/hero_dialog.dart';
import '../../../../core/utils/helper_packages/lazy_indexted_stack.dart';
import '../../../chat/presentation/cubits/chat/chat_cubit.dart';
import '../../../explore/presentation/blocs/explore_user/explore_user_cubit.dart';
import '../../../web/popup_new_post.dart';
import '../../../post_status_feed/presentation/bloc/following_post_feed/following_post_feed_bloc.dart';
import '../../../profile/presentation/pages/profile_page_wrapper.dart';
import '../../../post_status_feed/presentation/bloc/get_all_statsus/get_all_status_bloc.dart';
import '../../../post_status_feed/presentation/bloc/for_you_posts/get_my_status/get_my_status_bloc.dart';
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
  final FocusNode _focusNodeForExplore = FocusNode();
  void Function()? pauseReelsVideo;
  @override
  void initState() {
    serviceLocator<FirebaseHelper>()
        .deleteUnWantedStatus(context.read<AppUserBloc>().appUser.id);
    DeviceNotification.tokenRefresh(context.read<AppUserBloc>().appUser.id);

    WidgetsBinding.instance.addObserver(this);
    super.initState();
    _pages = getScreens(
      onPause: (pauseFunction) {
        pauseReelsVideo = pauseFunction;
      },
      focusNodeForExplore: _focusNodeForExplore,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    for (var controller in _controllers) {
      controller?.dispose();
    }
    log('bottom nav disposed');
    super.dispose();
  }

  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    final user = context.read<AppUserBloc>().appUser;
    return PopScope(
      canPop: _currentPage == 0,
      onPopInvoked: (didPop) {
        // if (!bottomBar.state.canPopFromTheExplore) return;

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
            bottomNavigationBar: Builder(builder: (context) {
              return BottomBarItems(
                  animateToIcon: (index) {
                    if (!isThatMobile && index == 2) {
                      _currentPage = index;

                      Navigator.of(context).push(HeroDialogRoute(
                          builder: (context) => const PopupNewPostWeb()));
                      return;
                    }
                    animateTheIcon(index);
                    if (index == 2 && _currentPage == 2) {
                      log('refresh the reels');
                      context.read<ReelsCubit>().getReels(user.id);
                    }
                    setState(() {
                      context.read<BottomBarCubit>().changeIndex(index);
                      if (_focusNodeForExplore.hasFocus == true) {
                        _focusNodeForExplore.unfocus();
                      }
                      _currentPage = index;
                    });
                  },
                  controllers: _controllers,
                  riveIconInputs: _riveIconInputs,
                  currentPage: _currentPage);
            })),
      ),
    );
  }
}
