import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/utils/responsive/responsive_helper.dart';
import 'package:social_media_app/core/utils/routes/tranistions/app_routes_const.dart';
import 'package:social_media_app/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:social_media_app/features/bottom_nav/presentation/pages/bottom_bar_builder.dart';
import 'package:social_media_app/features/bottom_nav/presentation/pages/bottom_nav.dart';
import 'package:social_media_app/features/bottom_nav/presentation/web/web_layout.dart';
import 'package:social_media_app/features/notification/data/datacource/remote/device_notification.dart';
import 'package:social_media_app/features/profile/presentation/pages/username_check_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
//!this splash will be changed this for testing purpose only

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

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
    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);
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
              // Rotating Dots
              // for (int i = 0; i < 6; i++) _buildDot(i),
              // Bottom Icon
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDot(int index) {
    final angle = (index * pi / 3);
    const radius = 80.0;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final offset = Offset(
          radius * cos(angle + _animation.value),
          radius * sin(angle + _animation.value),
        );
        return Transform.translate(
          offset: offset,
          child: child,
        );
      },
      child: const Dot(),
    );
  }
}

class Dot extends StatelessWidget {
  const Dot({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15,
      height: 15,
      decoration: const BoxDecoration(
        color: Colors.pink,
        shape: BoxShape.circle,
      ),
    );
  }
}
