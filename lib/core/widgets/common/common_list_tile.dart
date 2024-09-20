import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/widgets/common/app_svg.dart';

class CommonListTile extends StatelessWidget {
  const CommonListTile(
      {super.key,
      this.trailing,
      this.onTap,
      this.showTrail = true,
      this.iconSize = 20,
      this.noPadding = false,
      this.extraColor,
      this.text,
      this.subtitle,
      this.removePaddingRight = false,
      this.leading,
      this.titileStyle,
      this.subTitleSize,
      this.leadingW});
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
  final bool showTrail;
  final Widget? leadingW;
  final bool removePaddingRight;
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
                      ? subTitleSize ?? 10
                      : subTitleSize?.sp ?? 10,
                  color: extraColor),
            )
          : null,
      contentPadding: removePaddingRight
          ? const EdgeInsets.only(left: 16)
          : noPadding
              ? EdgeInsets.zero
              : null,
      title: text != null
          ? Text(
              text!,
              style: titileStyle ??
                  TextStyle(
                      color: extraColor,
                      fontSize: isThatTabOrDeskTop ? 20 : null),
            )
          : leadingW,
      trailing: showTrail
          ? trailing ??
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18,
              )
          : null,
    );
  }
}
