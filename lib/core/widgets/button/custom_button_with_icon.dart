import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/const/app_config/app_border_radius.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';

class CustomButtonWithIcon extends StatelessWidget {
  final VoidCallback onClick;
  final bool animate;
  final Color? backgroundColor;
  final IconData iconData;
  final Color? color;
  final double width;
  final double? height;
  final BorderRadiusGeometry? radius;
  final Color? borderColor;
  final Color? iconColor;
  final double? iconSize;
  final String title;
  final Color? textColor;
  final double? fontSize;
  const CustomButtonWithIcon({
    required this.onClick,
    this.color,
    this.textColor,
    required this.title,
    this.fontSize,
    this.radius,
    this.height,
    this.borderColor,
    this.iconSize,
    this.iconColor,
    this.width = double.infinity,
    required this.iconData,
    this.animate = true,
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: !isThatMobile ? 37 : 37.w,
      child: ElevatedButton.icon(
        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
            backgroundColor: WidgetStatePropertyAll(color),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: radius ?? AppBorderRadius.small,
                side: BorderSide(
                    color: borderColor ?? AppDarkColor().secondaryBackground,
                    width: 1.0),
              ),
            )),
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
          onClick();
        },
        icon: Icon(iconData, color: iconColor, size: iconSize),
        label: Text(title,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: textColor,
                fontSize: !isThatMobile 
                    ? fontSize
                    : fontSize?.sp)), // Display child widget as label
      ),
    );
  }
}
