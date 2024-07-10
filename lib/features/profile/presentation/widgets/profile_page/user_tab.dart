import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class UserTab extends StatelessWidget {
  const UserTab({super.key, required this.icon, required this.tabTitle});
  final String icon;
  final String tabTitle;
  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            width: 20,
            height: 20,
            'assets/svgs/explore.svg',
            colorFilter: ColorFilter.mode(
              AppDarkColor().iconSecondarycolor,
              BlendMode.srcIn,
            ),
          ),
          AppSizedBox.sizedBox10W,
          Text(tabTitle),
        ],
      ),
    );
  }
}
