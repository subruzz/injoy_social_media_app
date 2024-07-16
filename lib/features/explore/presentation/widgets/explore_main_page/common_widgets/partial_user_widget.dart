import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_app/core/add_at_symbol.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/const/app_config/app_border_radius.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/routes/app_routes_const.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/theme/widget_themes/text_theme.dart';
import 'package:social_media_app/core/widgets/app_related/common_text.dart';
import 'package:social_media_app/core/widgets/button/custom_elevated_button.dart';
import 'package:social_media_app/core/widgets/user_profile.dart';
import 'package:social_media_app/features/profile/presentation/bloc/follow_unfollow/followunfollow_cubit.dart';

class PartialUserWidget extends StatelessWidget {
  const PartialUserWidget({super.key, required this.user});
  final PartialUser user;
  @override
  Widget build(BuildContext context) {
    final me = context.read<AppUserBloc>().appUser;
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          MyAppRouteConst.otherUserProfile,
          extra: {
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
                Hero(
                  tag: user.id,
                  child: CircularUserProfile(
                    size: 27,
                    profile: user.profilePic,
                  ),
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
            CustomButton(
                width: null,
                height: 35,
                radius: AppBorderRadius.horizontalExtraLarge,
                child: BlocBuilder<FollowunfollowCubit, FollowunfollowState>(
                  builder: (context, state) {
                    log('our partial follo button builded and ${me.following.contains(user.id)} ');
                    return CustomText(
                        me.following.contains(user.id) ? 'Following' : 'Follow',
                        style: AppTextTheme.bodyMeidumwhiteVariant.bodyMedium
                            ?.copyWith(fontSize: 12));
                  },
                ),
                onClick: () {
                  final me = context.read<AppUserBloc>().appUser;
                  if (me.following.contains(user.id)) {
                    context
                        .read<FollowunfollowCubit>()
                        .unfollowUser(myId: me.id, otherId: user.id);
                  } else {
                    context
                        .read<FollowunfollowCubit>()
                        .followUser(me.id, user.id);
                  }
                }),
          ],
        ),
      ),
    );
  }
}
