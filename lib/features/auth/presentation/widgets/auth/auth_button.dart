import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_sizedbox.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class AuthButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onClick;
  final bool animate;
  final bool? isGoogleAuth;
  final Color? backgroundColor;

  const AuthButton({
    required this.child,
    required this.onClick,
    this.animate = true,
    this.isGoogleAuth,
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: const Duration(milliseconds: 0),
      duration: const Duration(milliseconds: 0),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isGoogleAuth != null
                ? Colors.white.withOpacity(.9)
                : AppDarkColor().buttonBackground,
          ),
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            onClick();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isGoogleAuth != null)
                Image.asset(
                  'assets/images/google.png',
                  height: 25,
                ),
              if (isGoogleAuth != null) AppSizedBox.sizedBox15W,
              child
            ],
          ),
        ),
      ),
    );
  }
}
