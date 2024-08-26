import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/widgets/app_related/app_svg.dart';

class PersonalChatTopBarIcon extends StatelessWidget {
  const PersonalChatTopBarIcon(
      {super.key, required this.onPressed, required this.index});
  final VoidCallback onPressed;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
            onTap: onPressed,
            child: CustomSvgIcon(
              assetPath: _chatPageTopBarIcons[index],
              width: 22,
            )),
        AppSizedBox.sizedBox15W,
      ],
    );
  }
}

const List<String> _chatPageTopBarIcons = [
  AppAssetsConst.delete,
  AppAssetsConst.moreIcon
];
