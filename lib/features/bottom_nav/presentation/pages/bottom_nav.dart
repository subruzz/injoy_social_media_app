import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/const/zego_const.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_event.dart';
import 'package:social_media_app/features/chat/presentation/pages/chat_main_tab_page.dart';
import 'package:social_media_app/features/explore/presentation/pages/explore.dart';
import 'package:social_media_app/features/bottom_nav/presentation/cubit/bottom_nav_cubit.dart';
import 'package:social_media_app/features/profile/presentation/pages/user_profile_page/personal_profile_page.dart';
import 'package:social_media_app/features/post_status_feed/presentation/pages/home.dart';
import 'package:social_media_app/core/utils/rive/model.dart';
import 'package:social_media_app/features/notification/presentation/pages/notification_page.dart';

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

  // void send() async {
  //   final fcm = FirebaseMessaging.instance;
  //   await fcm.requestPermission();
  //   final token = await fcm.getToken();
  //   print('token is $token');
  // }

  @override
  void initState() {
    // send();
    // PushNotificiationServices.sendNotificationToUser(
    //     'fCEODIumSvq-KH1rgjQO5_:APA91bFeT-FkhA22sW4wEe6OJYdMg1U4y3iWIns4K4xLXJ0uowUTgRA_YcpW9_dFwgBkq3pWcCo6B8YHnjclNEieoZZZC8OLvM2BzsYKnPaSCv23HUfv_VwWZhVNQUeslUvL2AZMzkwk');
    // final user = context.read<AppUserBloc>().appUser;
    // ZegoUIKitPrebuiltCallInvitationService().init(
    //   appID: ZegoConst.zegoAppId,
    //   appSign: ZegoConst.zegoAppSignIn,
    //   userID: user.id,
    //   userName: user.userName ?? '',
    //   plugins: [ZegoUIKitSignalingPlugin()],
    // );
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
    ExplorePage(),
    ChatMainTabPage(),
    const NotificationPage(),
    const PersonalProfilePage()
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
        artboard: "CHAT",
        stateMachineName: "CHAT_Interactivity"),
    RiveModel(
        src: "assets/animated-icons.riv",
        artboard: "BELL",
        stateMachineName: "BELL_Interactivity"),
    RiveModel(
        src: "assets/animated-icons.riv",
        artboard: "USER",
        stateMachineName: "USER_Interactivity"),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, BottomNavState>(
        builder: (context, state) {
      print(state.index);
      return Scaffold(
          body: pages[_currentPage],
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
    });
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
