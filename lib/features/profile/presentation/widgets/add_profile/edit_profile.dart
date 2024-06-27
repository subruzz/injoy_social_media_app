import 'package:flutter/material.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';


class EditProfileIcon extends StatelessWidget {
  const EditProfileIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.0),
        color: AppDarkColor().buttonBackground,
      ),
      child: const Icon(
        Icons.edit,
        color: Colors.black,
        size: 13,
      ),
    );
  }
}
