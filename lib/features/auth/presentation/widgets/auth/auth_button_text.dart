import 'package:flutter/material.dart';

import 'package:social_media_app/core/theme/color/app_colors.dart';

class AuthButtonText extends StatelessWidget {
  const AuthButtonText({
    super.key,
    required this.title,
    this.color,
  });

  final String title;
  final Color? color; 

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: color ?? AppDarkColor().primaryText), 
    );
  }
}
