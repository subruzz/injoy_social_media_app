import 'package:flutter/material.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class ReusablePopupMenuButton<T> extends StatelessWidget {
  final Widget icon;
  final List<PopupMenuEntry<T>> items;
  final Function(T)? onSelected;
  final VoidCallback? onCanceled;
  final T? initialValue;

  const ReusablePopupMenuButton({
    super.key,
    required this.icon,
    required this.items,
    this.onSelected,
    this.onCanceled,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      color: AppDarkColor().secondaryBackground,
      icon: icon,
      itemBuilder: (context) => items,
      onSelected: onSelected,
      onCanceled: onCanceled,
      initialValue: initialValue,
    );
  }
}
