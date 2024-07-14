import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/app_svg.dart';

class UserTab extends StatelessWidget {
  const UserTab(
      {super.key, required this.icon, required this.tabTitle, this.labelColor});
  final String icon;
  final String tabTitle;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomSvgIcon(
            assetPath: AppAssetsConst.explore,
            width: 18,
            height: 18,
            color: AppDarkColor().iconSecondarycolor,
          ),
          AppSizedBox.sizedBox10W,
          Text(
            tabTitle,
            style: TextStyle(color: labelColor),
          ),
        ],
      ),
    );
  }
}
