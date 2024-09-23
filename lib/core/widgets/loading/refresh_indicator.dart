import 'package:flutter/material.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class RefreshIndicatorWrapper extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;

  const RefreshIndicatorWrapper({
    super.key,
    required this.onRefresh,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      backgroundColor: Colors.white,
      color: AppDarkColor().buttonBackground,
      strokeWidth: 3,
      displacement: 40,
      edgeOffset: 20,
      child: child,
    );
  }
}
