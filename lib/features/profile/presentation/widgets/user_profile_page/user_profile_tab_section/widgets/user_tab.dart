import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/common/app_svg.dart';

import '../../../../../../../core/theme/widget_themes/text_theme.dart';

class UserTab extends StatelessWidget {
  const UserTab(
      {super.key,
      this.index = 0,
      required this.icon,
      required this.tabTitle,
      this.labelColor});
  final String icon;
  final String tabTitle;
  final Color? labelColor;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomSvgIcon(
            assetPath: index == 0 ? AppAssetsConst.post : AppAssetsConst.shorts,
            width: 18,
            height: 18,
            color: AppDarkColor().iconSoftColor,
          ),
          AppSizedBox.sizedBox10W,
          Text(tabTitle, style: AppTextTheme.appTextTheme.labelMedium),
        ],
      ),
    );
  }
}
