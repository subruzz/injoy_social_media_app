import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/widgets/app_related/app_svg.dart';

class CommonListTile extends StatelessWidget {
  const CommonListTile(
      {super.key,
      this.trailing,
      this.onTap,
      this.iconSize = 20,
      this.noPadding = false,
      this.extraColor,
      required this.text,
      this.subtitle,
      this.leading,
      this.titileStyle,
      this.subTitleSize});
  final double iconSize;
  final Widget? trailing;
  final String? subtitle;
  final String? text;
  final bool noPadding;
  final String? leading;
  final double? subTitleSize;
  final VoidCallback? onTap;
  final Color? extraColor;
  final TextStyle? titileStyle;
  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: onTap,
        leading: leading != null
            ? CustomSvgIcon(
                assetPath: leading!,
                height: iconSize,
                width: iconSize,
                color: extraColor,
              )
            : null,
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: isThatTabOrDeskTop
                        ? subTitleSize??10
                        : subTitleSize?.sp ?? 10,
                    color: extraColor),
              )
            : null,
        contentPadding: noPadding ? EdgeInsets.zero : null,
        title:text!=null? Text(
          text!,
          style: titileStyle ??
              TextStyle(
                  color: extraColor, fontSize: isThatTabOrDeskTop ? 20 : null),
        ):null,
        trailing: trailing);
  }
}
