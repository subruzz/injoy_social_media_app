import 'package:flutter/material.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/app_related/app_svg.dart';

class ExploreTabIcons extends StatelessWidget {
  const ExploreTabIcons(
      {super.key,
      required this.asset,
      this.h = false,
      required this.isSelected});
  final String asset;
  final bool h;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return CustomSvgIcon(
      assetPath: asset,
      height: h ? 23 : 19,
      width: 19,
      color: isSelected
          ? AppDarkColor().buttonBackground
          : AppDarkColor().iconPrimaryColor,
    );
  }
}
