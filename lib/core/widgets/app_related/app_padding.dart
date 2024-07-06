import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';

class CustomAppPadding extends StatelessWidget {
  const CustomAppPadding({super.key, this.padding, required this.child});
  final EdgeInsets? padding;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? AppPadding.horizontalMedium,
      child: child,
    );
  }
}
