// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:social_media_app/core/widgets/app_bar_common_icon.dart';

class AppCustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  AppCustomAppbar({
    super.key,
    this.showLeading = false,
    this.centerTitle = false,
    this.title,
    this.actions,
    this.leadingIcon,
    this.backGroundColor,
    this.leadingOnPressed,
  });
  final bool showLeading;
  final Color? backGroundColor;
  final bool centerTitle;
  final Widget? title;
  final IconData? leadingIcon;
  final VoidCallback? leadingOnPressed;
  List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: backGroundColor,
        automaticallyImplyLeading: showLeading,
        title: title,
        centerTitle: centerTitle,
        actions: actions,
        leading: showLeading
            ? IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: AppBarCommonIcon(icon: leadingIcon))
            : null);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
