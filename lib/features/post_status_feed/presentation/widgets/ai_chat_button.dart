import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/utils/routes/tranistions/app_routes_const.dart';
import 'package:social_media_app/features/bottom_nav/presentation/cubit/bottom_bar_cubit.dart';

import '../../../../core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import '../../../../core/services/app_interal/haptic_feedback.dart';
import '../../../../core/widgets/dialog/dialogs.dart';

class AiChatButton extends StatefulWidget {
  const AiChatButton({super.key});

  @override
  State<AiChatButton> createState() => _AiChatButtonState();
}

class _AiChatButtonState extends State<AiChatButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () {
      HapticFeedbackHelper().heavyImpact();
      if (!context.read<AppUserBloc>().appUser.hasPremium) {
        AppDialogsCommon.noPremium(context);
        return;
      }
      Navigator.pushNamed(context, MyAppRouteConst.aiChatPage);
    }, child: BlocBuilder<BottomBarCubit, BottomBarState>(
      builder: (context, state) {
        return Container(
          width: isThatMobile ? 40.w : 40,
          height: isThatMobile ? 40.h : 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.pink,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Icon(
              Icons.circle,
              color: Colors.white,
              size: 30.w,
            ),
          ),
        )
            .animate(autoPlay: true)
            .then(duration: const Duration(seconds: 6))
            .rotate(
                begin: 0, end: 2 * pi, duration: const Duration(seconds: 6));
      },
    ));
  }
}
