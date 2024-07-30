import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/const/app_config/app_border_radius.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';

class HomeTabBar extends StatelessWidget {
  const HomeTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.only(left: 13, bottom: 10),
      child: SizedBox(
        width: 200.w,
        child: TabBar(
          dividerHeight: 0,
          indicator: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.grey[700],
              borderRadius: AppBorderRadius.extraLarge),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
          tabs: const [TabText(text: 'Following'), TabText(text: 'For you')],
        ),
      ),
    );
  }
}

class TabText extends StatelessWidget {
  const TabText({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4.h),
      child: Text(text),
    );
  }
}
