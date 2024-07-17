import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_app/core/routes/app_routes_const.dart';
import 'package:social_media_app/core/shared_providers/blocs/initial_setup/initial_setup_cubit.dart';
import 'package:social_media_app/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:social_media_app/features/profile/presentation/bloc/get_user_posts_bloc/get_user_posts_bloc.dart';
import 'package:social_media_app/features/status/presentation/bloc/get_all_statsus/get_all_status_bloc.dart';
import 'package:social_media_app/features/status/presentation/bloc/get_my_status/get_my_status_bloc.dart';
import 'features/post_status_feed/presentation/bloc/following_post_feed/following_post_feed_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

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
            context.goNamed(MyAppRouteConst.loginRoute);
          }
          if (state is AuthLoggedInOrUpdate) {
            context.read<InitialSetupCubit>().startInitialSetup(
                uId: state.user.id, following: state.user.following);
            context.goNamed(MyAppRouteConst.bottomNavRoute, extra: state.user);
          }
          if (state is AuthLoggedInButProfileNotSet) {
            context.goNamed(MyAppRouteConst.addProfilePage, extra: state.user);
          }
        },
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              //logo needs to be changed
              Image.asset(
                'assets/image.png',
                height: 100,
                width: 100,
              ),
              // Rotating Dots
              for (int i = 0; i < 6; i++) _buildDot(i),
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
