import 'package:flutter/material.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/theme/widget_themes/text_theme.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/core/widgets/app_related/common_text.dart';
import 'package:social_media_app/core/widgets/user_profile.dart';

class UserBasicDetailSection extends StatelessWidget {
  const UserBasicDetailSection({super.key, required this.user});
  final AppUser user;
  @override
  Widget build(BuildContext context) {
    return CustomAppPadding(
      child: Column(
        children: [
          CircularUserProfile(
            wantSecProfile: true,
            size: 55,
            profile: user.profilePic,
          ),
          AppSizedBox.sizedBox3H,
          CustomText(
            user.fullName ?? '',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          AppSizedBox.sizedBox3H,
          if (user.occupation != null)
            CustomText(user.occupation ?? '',
                style: AppTextTheme.bodyMeidumLightGreyVariant.bodyMedium),
          AppSizedBox.sizedBox3H,
          if (user.about != null)
            CustomText(user.about ?? '',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}
