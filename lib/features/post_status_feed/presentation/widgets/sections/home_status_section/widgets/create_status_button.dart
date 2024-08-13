import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/utils/routes/tranistions/app_routes_const.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class CreateStatusButton extends StatelessWidget {
  const CreateStatusButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, MyAppRouteConst.statusCreationRoute);
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: AppDarkColor().buttonBackground),
        child: Padding(
          padding: AppPadding.extraSmall,
          child: Icon(
            Icons.add,
            color: AppDarkColor().background,
            size: 12.w,
          ),
        ),
      ),
    );
  }
}
