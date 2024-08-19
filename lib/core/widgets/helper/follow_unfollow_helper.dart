import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/const/extensions/localization.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/widgets/app_related/common_text.dart';

import '../../../features/profile/presentation/bloc/other_user/follow_unfollow/followunfollow_cubit.dart';
import '../../const/app_config/app_border_radius.dart';
import '../../theme/widget_themes/text_theme.dart';
import '../button/custom_elevated_button.dart';

class FollowUnfollowHelper extends StatelessWidget {
  const FollowUnfollowHelper(
      {super.key,
      required this.user,
      this.wantWhiteBorder = false,
      this.isFromCard = false,
      this.noRad = false,
      this.color});
  final PartialUser user;
  final bool isFromCard;
  final bool noRad;
  final Color? color;
  final bool wantWhiteBorder;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return CustomButton(
        borderColor: wantWhiteBorder ? Colors.white : null,
        color: color,
        width: isFromCard ? 100 : null,
        height: isFromCard ? 40 : 35,
        radius: noRad ? AppBorderRadius.small : null,
        child: BlocBuilder<FollowunfollowCubit, FollowunfollowState>(
          builder: (context, state) {
            final me = context.read<AppUserBloc>().appUser;

            return CustomText(
                text: me.following.contains(user.id)
                    ? l10n!.following
                    : l10n!.follow,
                style: AppTextTheme.getResponsiveTextTheme(context)
                    .bodySmall
                    ?.copyWith(  color: AppDarkColor().primaryText));
          },
        ),
        onClick: () {
          final me = context.read<AppUserBloc>().appUser;
          final amIFollowing = me.following.contains(user.id);
          log(amIFollowing.toString());
          if (amIFollowing) {
            me.following.remove(user.id);
          } else {
            me.following.add(user.id);
          }
          context.read<FollowunfollowCubit>().followUnfollowAction(
              user: me,
              myid: me.id,
              otherId: user.id,
              isFollowing: amIFollowing);
        });
  }
}
