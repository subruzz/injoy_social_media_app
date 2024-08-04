import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/widgets/app_svg.dart';

class CommonListTile extends StatelessWidget {
  const CommonListTile(
      {super.key,
      this.trailing,
      this.onTap,
      this.noPadding = false,
      required this.text,
      this.subtitle,
      this.leading});
  final Widget? trailing;
  final String? subtitle;
  final String text;
  final bool noPadding;
  final String? leading;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: onTap,
        leading: leading != null
            ? CustomSvgIcon(
                assetPath: leading!,
                height: 20,
                width: 20,
              )
            : null,
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: 10.sp),
              )
            : null,
        contentPadding: noPadding ? EdgeInsets.zero : null,
        title: Text(text),
        trailing: trailing);
  }
}
