import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/widgets/app_svg.dart';

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
                height: index == 0
                    ? 20
                    : index == 2
                        ? 22
                        : 24)),
        AppSizedBox.sizedBox15W,
      ],
    );
  }
}

const List<String> _chatPageTopBarIcons = [
  AppAssetsConst.call,
  AppAssetsConst.video,
  AppAssetsConst.moreIcon
];
