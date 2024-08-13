import 'package:flutter/material.dart';
import 'package:social_media_app/core/widgets/app_related/app_svg.dart';

class SettingsListTile extends StatelessWidget {
  const SettingsListTile(
      {super.key,
      this.onTap,
      this.title,
      this.subTitle,
      this.trailing,
      this.leading});
  final VoidCallback? onTap;
  final String? title;
  final String? leading;
  final String? subTitle;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading != null ? CustomSvgIcon(assetPath: leading!) : null,
      title: Text(title ?? ''),
      subtitle: Text(subTitle ?? ''),
      trailing: trailing,
      onTap: () {},
    );
  }
}
