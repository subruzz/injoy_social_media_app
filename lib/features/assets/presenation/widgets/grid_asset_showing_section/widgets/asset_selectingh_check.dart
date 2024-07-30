import 'package:flutter/material.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';

class AssetSelectinghCheckIcon extends StatelessWidget {
  const AssetSelectinghCheckIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppDarkColor().iconSoftColor,
      ),
      child: const CustomAppPadding(
        padding: EdgeInsets.all(6),
        child: Icon(Icons.check, color: Colors.white, size: 20),
      ),
    );
  }
}
