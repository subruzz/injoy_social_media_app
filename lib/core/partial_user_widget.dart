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
  const PartialUserWidget(
      {super.key,
      this.replaceFullName,
      this.wantFollowB = true,
      required this.user});
  final PartialUser user;
  final bool wantFollowB;
  final String? replaceFullName;
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
            Expanded(
              child: Row(
                children: [
                  CircularUserProfile(
                    size: 27,
                    profile: user.profilePic,
                  ),
                  AppSizedBox.sizedBox15W,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: addAtSymbol(user.userName),
                          maxLines: 1,
                        ),
                        CustomText(
                          maxLines: 1,
                          text: replaceFullName ?? user.fullName ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontSize: isThatTabOrDeskTop ? 13 : null),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (wantFollowB &&
                user.id != context.read<AppUserBloc>().appUser.id)
              FollowUnfollowHelper(user: user),
          ],
        ),
      ),
    );
  }
}
