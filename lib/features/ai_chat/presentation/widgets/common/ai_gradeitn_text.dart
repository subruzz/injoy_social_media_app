import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/animation/animations.dart';
import '../../../../../core/theme/color/const_colors.dart';

class AiGradientText extends StatelessWidget {
  const AiGradientText({super.key, this.fSize, required this.text});
  final String text;
  final double? fSize;
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        shaderCallback: (rect) => const LinearGradient(
              colors: aiMsgColor,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(rect),
        child: TextShimmerAnimation(
          child: Text(
            text,
            style: TextStyle(
              fontSize: fSize != null ? fSize?.sp : 17.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ));
  }
}
