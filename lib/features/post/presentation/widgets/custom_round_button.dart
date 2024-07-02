import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_padding.dart';

class CustomRoundButton extends StatelessWidget {
  const CustomRoundButton(
      {super.key, required this.icon, required this.onPressed});
  final IconData icon;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      style: ElevatedButton.styleFrom(
          shape: const CircleBorder(), padding: AppPadding.extraSmall),
      child: Icon(icon),
    );
  }
}
