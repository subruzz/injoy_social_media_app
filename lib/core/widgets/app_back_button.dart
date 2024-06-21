import 'package:flutter/material.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.arrow_back_ios_outlined,
        color: AppDarkColor().iconPrimaryColor,
        size: 30,
      ),
    );
  }
}
