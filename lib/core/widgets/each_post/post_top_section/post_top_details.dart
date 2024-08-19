import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/extensions/time_ago.dart';
import 'package:social_media_app/core/theme/widget_themes/text_theme.dart';
import 'package:social_media_app/core/utils/responsive/responsive_helper.dart';
import 'package:social_media_app/core/utils/routes/tranistions/app_routes_const.dart';
import 'package:social_media_app/core/widgets/app_related/common_text.dart';
import 'package:social_media_app/core/widgets/common/user_profile.dart';
import 'package:social_media_app/core/widgets/dialog/general_dialog_for_web.dart';
import 'package:social_media_app/core/widgets/each_post/post_action_section/post_action_section.dart';
import 'package:social_media_app/core/widgets/each_post/post_action_section/widgets/post_like_button.dart';
import 'package:social_media_app/core/widgets/each_post/post_top_section/widgets/post_option_button.dart';
import 'package:social_media_app/features/profile/presentation/pages/other_user_profile.dart';

import '../../../common/models/partial_user_model.dart';
import '../../../utils/responsive/constants.dart';

class PostTopDetails extends StatelessWidget {
  const PostTopDetails({
    super.key,
    required this.post,
    required this.pagecontroller,
    required this.currentPostIndex,
  });

  final PostEntity post;
  final PageController pagecontroller;
  final int currentPostIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (isThatTabOrDeskTop) {
                    GeneralDialogForWeb.showSideDialog(
                      alignment: Alignment.centerLeft,
                      width: 500,
                      context: context,
                      child: OtherUserProfilePage(
                        user: PartialUser(
                          id: post.creatorUid,
                          userName: post.userFullName,
                          fullName: post.userFullName,
                          profilePic: post.userProfileUrl,
                        ),
                      ),
                    );
                    return;
                  }
                  Navigator.pushNamed(context, MyAppRouteConst.otherUserProfile,
                      arguments: {
                        'user': PartialUser(
                            id: post.creatorUid,
                            userName: post.userFullName,
                            fullName: post.userFullName,
                            profilePic: post.userProfileUrl)
                      });
                },
                child: CircularUserProfile(
                  profile: post.userProfileUrl,
                  size: 22,
                ),
              ),
              AppSizedBox.sizedBox10W,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: CustomText(
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            text: '@${post.username}',
                            style: AppTextTheme.getResponsiveTextTheme(context)
                                .labelSmall,
                          ),
                        ),
                        AppSizedBox.sizedBox15W,
                        Flexible(
                          child: CustomText(
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            text: post.createAt.toDate().timeAgo(),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                    CustomText(
                      maxLines: 1,
                      text: post.userFullName,
                      style: AppTextTheme.getResponsiveTextTheme(context)
                          .bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (!kIsWeb)
          PostOptionButton(
            currentPostIndex: currentPostIndex,
            isMyPost: context.read<AppUserBloc>().appUser.id == post.creatorUid,
            pagecontroller: pagecontroller,
            post: post,
          ),
      ],
    );
  }
}
