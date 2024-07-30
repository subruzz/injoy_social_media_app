import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/sections/home_status_section/widgets/current_user_status.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/sections/home_status_section/widgets/following_user_status.dart';

class UserStatus extends StatelessWidget {
  const UserStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90.h,
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyStatusView(),
          FollowingUserStatus(),
        ],
      ),
    );
  }
}
