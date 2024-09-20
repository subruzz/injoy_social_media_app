import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/utils/responsive/responsive_helper.dart';
import 'package:social_media_app/core/utils/routes/tranistions/app_routes_const.dart';
import 'package:social_media_app/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:social_media_app/features/bottom_nav/presentation/pages/bottom_bar_builder.dart';
import 'package:social_media_app/features/bottom_nav/presentation/web/web_layout.dart';
import 'package:social_media_app/features/notification/data/datacource/remote/device_notification.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    if (isThatMobile) {
      DeviceNotification.requestPermission();
    }
    // PushNotificiationServices.init();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthNotLoggedIn) {
            Navigator.pushReplacementNamed(context, MyAppRouteConst.loginRoute);
          }
          if (state is AuthLoggedInOrUpdate) {
            // context.read<InitialSetupCubit>().startInitialSetup(
            //     uId: state.user.id, following: state.user.following);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const Responsive(
                  mobile: BottomBarBuilder(),
                  tablet: WebLayout(),
                  desktop: WebLayout()),
            ));
          }
          if (state is AuthLoggedInButProfileNotSet) {
            Navigator.pushReplacementNamed(
              context,
              MyAppRouteConst.addProfilePage,
            );
          }
        },
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              //logo needs to be changed

              Image.asset(
                'assets/images/app_logo.png',
                height: 120,
                width: 120,
              ),
              
            ],
          ),
        ),
      ),
    );
  }

}

