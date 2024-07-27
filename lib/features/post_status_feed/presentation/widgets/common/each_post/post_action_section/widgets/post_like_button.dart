import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/theme/widget_themes/text_theme.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/like_post/like_post_bloc.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/common/each_post/post_action_section/widgets/social_action_text.dart';

import '../../../../../../../../core/const/app_config/app_sizedbox.dart';

class PostLikeButton extends StatelessWidget {
  const PostLikeButton({super.key, required this.me, required this.post});
  final AppUser me;
  final PostEntity post;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LikePostBloc, LikePostState>(
      builder: (context, state) {
        return Row(
          children: [
            GestureDetector(
                onTap: () {
                  if (post.likes.contains(me.id)) {
                    post.likes.remove(me.id);

                    context.read<LikePostBloc>().add(UnlikePostClickEvent(
                        postId: post.postId,
                        myId: me.id,
                        ohterUseId: post.creatorUid));
                  } else {
                    // likeAnim();
                    post.likes.add(me.id);
                    context.read<LikePostBloc>().add(LikePostClickEvent(
                        user: me,
                        postId: post.postId,
                        otherUserId: post.creatorUid));
                  }
                },
                child: Icon(
                    size: 25,
                    post.likes.contains(me.id)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: post.likes.contains(me.id)
                        ? AppDarkColor().iconSecondarycolor
                        : AppDarkColor().iconSoftColor)),
            AppSizedBox.sizedBox5W,
            SocialActionText(text: post.likes.length.toString())
          ],
        );
      },
    );
  }
}
