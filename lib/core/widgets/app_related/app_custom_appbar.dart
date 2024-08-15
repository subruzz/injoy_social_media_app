// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppCustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  AppCustomAppbar({
    super.key,
    this.showLeading = true,
    this.centerTitle = false,
    this.title,
    this.actions,
    this.leadingIcon,
    this.titleSize,
    this.backGroundColor,
    this.style,
    this.leadingOnPressed,
  });
  final TextStyle? style;
  final bool showLeading;
  final Color? backGroundColor;
  final bool centerTitle;
  final String? title;
  final IconData? leadingIcon;
  final VoidCallback? leadingOnPressed;
  List<Widget>? actions;
  final double? titleSize;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backGroundColor,
      automaticallyImplyLeading: showLeading,
      title: title != null
          ? Text(
              title!,
              style: style ??
                  Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w600, fontSize: titleSize?.sp),
            )
          : null,
      centerTitle: centerTitle,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
