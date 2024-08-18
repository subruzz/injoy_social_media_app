import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/widgets/common/add_at_symbol.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/utils/routes/tranistions/app_routes_const.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/widgets/app_related/common_text.dart';
import 'package:social_media_app/core/widgets/helper/follow_unfollow_helper.dart';
import 'package:social_media_app/core/widgets/common/user_profile.dart';

class PartialUserWidget extends StatelessWidget {
  const PartialUserWidget({super.key, required this.user});
  final PartialUser user;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          MyAppRouteConst.otherUserProfile,
          arguments: {
            'userName': user.userName ?? '',
            'otherUserId': user.id,
          },
        );
      },
      child: Padding(
        padding: AppPadding.verticalSmall,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircularUserProfile(
                  size: 27,
                  profile: user.profilePic,
                ),
                AppSizedBox.sizedBox15W,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: addAtSymbol(user.userName)),
                    CustomText(
                      text: user.fullName ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: isThatTabOrDeskTop ? 13 : null),
                    )
                  ],
                ),
              ],
            ),
            if (user.id != context.read<AppUserBloc>().appUser.id)
              FollowUnfollowHelper(user: user),
          ],
        ),
      ),
    );
  }
}
