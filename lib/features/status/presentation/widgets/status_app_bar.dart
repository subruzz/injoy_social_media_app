import 'package:flutter/material.dart';
import 'package:social_media_app/core/widgets/app_bar_common_icon.dart';

class StatusAppBar extends StatelessWidget implements PreferredSizeWidget {
  const StatusAppBar({super.key, required this.actions, this.color});
  final List<Widget> actions;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color,
      title: Text(
        'Create Status',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
      leading: const AppBarCommonIcon(
        icon: null,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
