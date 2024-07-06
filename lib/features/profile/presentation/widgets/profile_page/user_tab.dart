import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';

class UserTab extends StatelessWidget {
  const UserTab({super.key, required this.icon, required this.tabTitle});
  final IconData icon;
  final String tabTitle;
  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          AppSizedBox.sizedBox5H,
          Text(tabTitle),
        ],
      ),
    );
  }
}
