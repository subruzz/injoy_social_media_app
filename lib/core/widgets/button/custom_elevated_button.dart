import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/const/app_config/app_border_radius.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onClick;
  final bool animate;
  final Color? backgroundColor;
  final Widget? buttonIcon;
  final Color? color;
  final double width;
  final double? height;
  final BorderRadiusGeometry? radius;
  final Color? borderColor;
  const CustomButton({
    required this.child,
    required this.onClick,
    this.color,
    this.radius,
    this.height,
    this.borderColor,
    this.width = double.infinity,
    this.buttonIcon,
    this.animate = true,
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: const Duration(milliseconds: 0),
      duration: const Duration(milliseconds: 0),
      child: SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (buttonIcon != null) buttonIcon!,
              if (buttonIcon != null) AppSizedBox.sizedBox10W,
              child
            ],
          ),
        ),
      ),
    );
  }
}
