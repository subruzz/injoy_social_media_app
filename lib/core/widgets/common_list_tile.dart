import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonListTile extends StatelessWidget {
  const CommonListTile(
      {super.key,
      this.trailing,
      this.onTap,
      required this.text,
      this.subtitle,
      this.icon});
  final Widget? trailing;
  final String? subtitle;
  final String text;
  final IconData? icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: onTap,
        leading: icon != null ? Icon(icon) : null,
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: 10.sp),
              )
            : null,
        contentPadding: EdgeInsets.zero,
        title: Text(text),
        trailing: trailing);
  }
}
