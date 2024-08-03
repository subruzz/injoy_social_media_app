import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/widgets/app_related/common_text.dart';

import '../../features/profile/presentation/bloc/follow_unfollow/followunfollow_cubit.dart';
import '../const/app_config/app_border_radius.dart';
import '../theme/widget_themes/text_theme.dart';
import 'button/custom_elevated_button.dart';

class FollowUnfollowHelper extends StatelessWidget {
  const FollowUnfollowHelper(
      {super.key, required this.user, this.isFromCard = false});
  final PartialUser user;
  final bool isFromCard;
  @override
  Widget build(BuildContext context) {
    return CustomButton(
        width: isFromCard ? 120 : null,
        height: isFromCard ? 40 : 35,
        radius: isFromCard ? null : AppBorderRadius.horizontalExtraLarge,
        child: BlocBuilder<FollowunfollowCubit, FollowunfollowState>(
          builder: (context, state) {
            final me = context.read<AppUserBloc>().appUser;

            return CustomText(
                me.following.contains(user.id) ? 'Following' : 'Follow',
                style: AppTextTheme.bodyMeidumwhiteVariant.bodyMedium
                    ?.copyWith(fontSize: 12));
          },
        ),
        onClick: () {
          final me = context.read<AppUserBloc>().appUser;
          final amIFollowing = me.following.contains(user.id);
          // if (user.followersCount == null) return;
          // if (amIFollowing) {
          //   me.following.remove(user.id);
          //   --user.followersCount!;
          // } else {
          //   ++user.followersCount!;
          //   me.following.add(user.id);
          // }
          context.read<FollowunfollowCubit>().followUnfollowAction(
              user: me,
              myid: me.id,
              otherId: user.id,
              isFollowing: amIFollowing);
        });
  }
}
