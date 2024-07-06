import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';

class CustomButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onClick;
  final bool animate;
  final Color? backgroundColor;
  final bool isShowIcon;
  final Color? color;
  final double width;

  const CustomButton({
    required this.child,
    required this.onClick,
    this.color,
    this.width = double.infinity,
    this.isShowIcon = false,
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
        child: ElevatedButton(
          style: Theme.of(context)
              .elevatedButtonTheme
              .style
              ?.copyWith(backgroundColor: WidgetStatePropertyAll(color)),
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            onClick();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isShowIcon)
                Image.asset(
                  AppAssetsConst.googleLogo,
                  height: 25.h,
                ),
              if (isShowIcon) AppSizedBox.sizedBox15W,
              child
            ],
          ),
        ),
      ),
    );
  }
}
