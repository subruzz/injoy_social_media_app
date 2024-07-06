import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/const/app_config/app_border_radius.dart';
import 'package:social_media_app/core/widgets/app_related/app_custom_floating_button.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key, required this.onpressed,required this.child});
  final void Function() onpressed;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.w,
      child: AppCustomFloatingButton(
        shape: OutlineInputBorder(borderRadius: AppBorderRadius.small),
        onPressed: onpressed,
        child: CustomAppPadding(
          child:child
        ),
      ),
    );
  }
}
