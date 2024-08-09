import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';

import '../../../../../core/theme/color/const_colors.dart';

class AiProfile extends StatelessWidget {
  const AiProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130.w,
      height: 120.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: aiProfileColor,
        border: Border.all(color: Colors.white, width: 4),
      ),
      child: ClipOval(
        child: Image.asset(
          AppAssetsConst.ai,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
