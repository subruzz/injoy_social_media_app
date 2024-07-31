import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/widgets/follow_unfollow_helper.dart';
import '../../../../../../core/common/models/partial_user_model.dart';
import '../../../../../../core/const/app_config/app_border_radius.dart';
import '../../../../../../core/const/app_config/app_sizedbox.dart';
import '../../../../../../core/theme/color/app_colors.dart';
import '../../../../../../core/widgets/user_profile.dart';

class UserCard extends StatelessWidget {
  final PartialUser user;
  final ValueNotifier<int> isActive;
  final int index;

  const UserCard({
    super.key,
    required this.user,
    required this.isActive,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: isActive,
      builder: (context, value, child) {
        final active = isActive.value == index;

        final double margin = active ? 0 : 25;

        return SizedBox(
          height: 0.55.sh,
          width: 0.8.sw,
          child: Padding(
            padding: AppPadding.small,
            child: AnimatedContainer(
              decoration: BoxDecoration(
                color: AppDarkColor().secondaryBackground,
                borderRadius: AppBorderRadius.small,
              ),
              margin: EdgeInsets.only(top: margin, bottom: margin),
              curve: Curves.easeOutQuint,
              duration: const Duration(milliseconds: 500),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 60.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularUserProfile(
                      profile: user.profilePic,
                      size: 50,
                    ),
                    AppSizedBox.sizedBox10H,
                    Text(user.userName ?? '',
                        style: Theme.of(context).textTheme.headlineSmall),
                    Text(user.fullName ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: AppDarkColor().secondaryText)),
                    AppSizedBox.sizedBox10H,
                    const Spacer(),
                    FollowUnfollowHelper(user: user,isFromCard: true,),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
