import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/const/app_config/app_border_radius.dart';

class HomeTabBar extends StatelessWidget {
  const HomeTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, bottom: 10),
      child: Container(
        alignment: Alignment.center,
        width: 200.w,
        height: 30.h,
        child: TabBar(
          dividerHeight: 0,
          indicator: BoxDecoration(
              color: Colors.grey[700],
              borderRadius: AppBorderRadius.extraLarge),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
          tabs: const [
            Tab(
              text: 'Following',
            ),
            Tab(
              text: 'For you',
            ),
          ],
        ),
      ),
    );
  }
}
