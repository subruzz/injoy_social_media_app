import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/add_at_symbol.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/routes/app_routes_const.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/widgets/app_related/common_text.dart';
import 'package:social_media_app/core/widgets/follow_unfollow_helper.dart';
import 'package:social_media_app/core/widgets/user_profile.dart';

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
                    CustomText(addAtSymbol(user.userName)),
                    CustomText(
                      user.fullName ?? '',
                      style: Theme.of(context).textTheme.bodyMedium,
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
