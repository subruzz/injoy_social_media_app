import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/widgets/common/app_svg.dart';

class MulitplePostOrShortsIndicator extends StatelessWidget {
  const MulitplePostOrShortsIndicator(
      {super.key,
      this.showIndicator = false,
      this.isThatShorts = false,
      required this.child});
  final bool showIndicator;
  final Widget child;
  final bool isThatShorts;
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      alignment: Alignment.topRight,
      children: [
        child,
        if (showIndicator)
          const CustomSvgIcon(
            assetPath: AppAssetsConst.photos,
            color: Colors.white,
          ),
        if (isThatShorts)
          const CustomSvgIcon(
            assetPath: AppAssetsConst.shorts,
            color: Colors.white,
          ),
      ],
    );
  }
}
