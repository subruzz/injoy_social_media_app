import 'package:flutter/material.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(color: AppDarkColor().softBackground);
  }
}
