import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_event.dart';
import 'package:social_media_app/core/services/app_interal/haptic_feedback.dart';
import 'package:social_media_app/features/chat/presentation/pages/chat_main_tab_page.dart';
import 'package:social_media_app/features/bottom_nav/presentation/cubit/bottom_nav_cubit.dart';
import 'package:social_media_app/features/explore/presentation/pages/explore_page_builder.dart';
import 'package:social_media_app/features/post_status_feed/presentation/pages/home.dart';
import 'package:social_media_app/core/utils/rive/model.dart';
import 'package:social_media_app/features/reels/presentation/pages/video_page.dart';
import 'package:social_media_app/features/reels/presentation/bloc/reels/reels_cubit.dart';
import 'package:social_media_app/core/utils/di/init_dependecies.dart';

import '../../../chat/presentation/cubits/chat/chat_cubit.dart';
import '../../../explore/presentation/blocs/explore_user/explore_user_cubit.dart';
import '../../../post/presentation/bloc/posts_blocs/create_post/create_post_bloc.dart';
import '../../../post_status_feed/presentation/bloc/following_post_feed/following_post_feed_bloc.dart';
import '../../../profile/presentation/pages/profile_page_wrapper.dart';
import '../../../status/presentation/bloc/get_all_statsus/get_all_status_bloc.dart';
import '../../../status/presentation/bloc/get_my_status/get_my_status_bloc.dart';

const Color bottonNavBgColor = Color(0xFF17203A);

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

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    for (var controller in controllers) {
      controller?.dispose();
    }

    super.dispose();
  }

  List<SMIBool> riveIconInputs = [];
  List<StateMachineController?> controllers = [];
  List<Widget> pages = [
    const HomePage(),
    const ExplorePageBuilder(),
    const VideoReelPage(),
    const ChatMainTabPage(),
    const ProfilePageWrapper()
  ];

  void animateTheIcon(int index) {
    riveIconInputs[index].change(true);
    Future.delayed(
      const Duration(seconds: 1),
      () {
        riveIconInputs[index].change(false);
      },
    );
  }

  void riveOnInIt(Artboard artboard, {required String stateMachineName}) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, stateMachineName);

    artboard.addController(controller!);
    controllers.add(controller);

    riveIconInputs.add(controller.findInput<bool>('active') as SMIBool);
  }

  int _currentPage = 0;
  List<RiveModel> bottomNavItems = [
    RiveModel(
        src: "assets/animated-icons.riv",
        artboard: "HOME",
        stateMachineName: "HOME_interactivity"),
    RiveModel(
        src: "assets/animated-icons.riv",
        artboard: "SEARCH",
        stateMachineName: "SEARCH_Interactivity"),
    RiveModel(
        src: "assets/animated-icons.riv",
        artboard: "TIMER",
        stateMachineName: "TIMER_Interactivity"),
    RiveModel(
        src: "assets/animated-icons.riv",
        artboard: "CHAT",
        stateMachineName: "CHAT_Interactivity"),
    RiveModel(
        src: "assets/animated-icons.riv",
        artboard: "USER",
        stateMachineName: "USER_Interactivity"),
  ];

  @override
  Widget build(BuildContext context) {
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
          providers: [
            BlocProvider(create: (context) {
              final user = context.read<AppUserBloc>().appUser;
              return serviceLocator<FollowingPostFeedBloc>()
                ..add(FollowingPostFeedGetEvent(
                    isLoadMore: false,
                    lastDoc: null,
                    isFirst: true,
                    following: user.following,
                    uId: user.id));
            }),
            BlocProvider(create: (context) {
              final user = context.read<AppUserBloc>().appUser;
              return serviceLocator<ReelsCubit>()..getReels(user.id);
            }), 
            BlocProvider(
              create: (context) => serviceLocator<GetMyStatusBloc>()
                ..add(GetAllMystatusesEvent(
                    uId: context.read<AppUserBloc>().appUser.id)),
            ),
            BlocProvider(
              create: (context) => serviceLocator<CreatePostBloc>(),
            ),
            BlocProvider(
                create: (context) => serviceLocator<GetAllStatusBloc>()
                  ..add(GetAllstatusesEvent(
                      uId: context.read<AppUserBloc>().appUser.id))),
            BlocProvider(
              create: (context) => serviceLocator<ExploreAllPostsCubit>()
                ..getAllposts(myId: context.read<AppUserBloc>().appUser.id),
            ),
            BlocProvider(
                create: (context) => serviceLocator<ChatCubit>()
                  ..getMyChats(myId: context.read<AppUserBloc>().appUser.id)),
          ],
          child: BlocBuilder<BottomNavCubit, BottomNavState>(
              builder: (context, state) {
            return Scaffold(
                body: LazyIndexedStack(
                  index: _currentPage,
                  children: List.generate(5, (i) => pages[i]),
                ),
                bottomNavigationBar: Container(
                  padding: const EdgeInsets.all(6),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: bottonNavBgColor.withOpacity(0.8),
                    borderRadius: const BorderRadius.all(Radius.circular(24)),
                    boxShadow: [
                      BoxShadow(
                        color: bottonNavBgColor.withOpacity(0.3),
                        offset: const Offset(0, 20),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      bottomNavItems.length,
                      (index) {
                        final riveIcon = bottomNavItems[index];
                        return GestureDetector(
                          onTap: () {
                            HapticFeedbackHelper().vibrate();
                            animateTheIcon(index);
                            setState(() {
                              _currentPage = index;
                            });
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AnimatedBar(isActive: _currentPage == index),
                              SizedBox(
                                height: 36,
                                width: 36,
                                child: Opacity(
                                  opacity: _currentPage == index ? 1 : 0.5,
                                  child: RiveAnimation.asset(
                                    riveIcon.src,
                                    artboard: riveIcon.artboard,
                                    onInit: (artboard) {
                                      riveOnInIt(artboard,
                                          stateMachineName:
                                              riveIcon.stateMachineName);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ));
          })),
    );
  }
}

class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    super.key,
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 2),
      height: 4,
      width: isActive ? 20 : 0,
      decoration: const BoxDecoration(
        color: Color(0xFF81B4FF),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

/// {@template lazy_indexed_stack}
/// A widget that displays a [IndexedStack] with lazy loaded children.
/// {@endtemplate}
class LazyIndexedStack extends StatefulWidget {
  /// {@macro lazy_indexed_stack}
  const LazyIndexedStack({
    super.key,
    this.index = 0,
    this.children = const [],
    this.alignment = AlignmentDirectional.topStart,
    this.textDirection,
    this.sizing = StackFit.loose,
  });

  /// The index of the child to display.
  final int index;

  /// The list of children that can be displayed.
  final List<Widget> children;

  /// How to align the children in the stack.
  final AlignmentGeometry alignment;

  /// The direction to use for resolving [alignment].
  final TextDirection? textDirection;

  /// How to size the non-positioned children in the stack.
  final StackFit sizing;

  @override
  State<LazyIndexedStack> createState() => _LazyIndexedStackState();
}

class _LazyIndexedStackState extends State<LazyIndexedStack> {
  late final List<bool> _activatedChildren;

  @override
  void initState() {
    super.initState();
    _activatedChildren = List.generate(
      widget.children.length,
      (i) => i == widget.index,
    );
  }

  @override
  void didUpdateWidget(LazyIndexedStack oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index) _activateChild(widget.index);
  }

  void _activateChild(int? index) {
    if (index == null) return;
    if (!_activatedChildren[index]) _activatedChildren[index] = true;
  }

  List<Widget> get children {
    return List.generate(
      widget.children.length,
      (i) {
        return _activatedChildren[i]
            ? widget.children[i]
            : const SizedBox.shrink();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      alignment: widget.alignment,
      textDirection: widget.textDirection,
      sizing: widget.sizing,
      index: widget.index,
      children: children,
    );
  }
}
