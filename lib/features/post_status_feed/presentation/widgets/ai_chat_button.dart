import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/utils/routes/tranistions/app_routes_const.dart';

import '../../../../core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import '../../../../core/services/app_interal/haptic_feedback.dart';
import '../../../../core/widgets/dialog/dialogs.dart';

class AiChatButton extends StatelessWidget {
  const AiChatButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedbackHelper().heavyImpact();
        if (!context.read<AppUserBloc>().appUser.hasPremium) {
          AppDialogsCommon.noPremium(context);
          return;
        }
        Navigator.pushNamed(context, MyAppRouteConst.aiChatPage);
      },
      child: Container(
        width: 40.w,
        height: 40.h,
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
          .animate()
          .then(duration: const Duration(seconds: 6))
          .rotate(begin: 0, end: 2 * pi, duration: const Duration(seconds: 6)),
    );
  }
}
