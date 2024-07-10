import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/core/widgets/post/post_attributes.dart';
import 'package:social_media_app/features/post/presentation/bloc/like_post/like_post_bloc.dart';

class PostActionBar extends StatelessWidget {
  const PostActionBar({super.key, required this.post});
  final PostEntity post;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BlocBuilder<LikePostBloc, LikePostState>(
          builder: (context, state) {
            return PostAttributes(
                onTap: () {
                  // if (post.likes.contains(currentUserId)) {
                  //   post.likes
                  //       .removeWhere((element) => element == currentUserId);
                  // } else {
                  //   post.likes.add(currentUserId);
                  // }
                  // context
                  //     .read<LikePostBloc>()
                  //     .add(LikePostClickEvent(postId: post.postId));
                },
                icon: Icon(
                  Icons.favorite,
                  color: AppDarkColor().iconSecondarycolor,
                ),
                count: 0);
          },
        ),
        AppSizedBox.sizedBox10W,
        PostAttributes(
          icon: Icon(
            Icons.chat_bubble_outline,
          ),
          count: 2,
          onTap: () {},
        ),
        Transform.rotate(
          angle: 0,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.send_outlined,
              size: 17,
            ),
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class SocialActions extends StatelessWidget {
  const SocialActions({super.key, required this.post});
  final PostEntity post;

  @override
  Widget build(BuildContext context) {
    final appUser = context.read<AppUserBloc>().appUser;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Likes
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BlocBuilder<LikePostBloc, LikePostState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            if (post.likes.contains(appUser.id)) {
                              post.likes.remove(appUser.id);

                              context.read<LikePostBloc>().add(
                                  UnlikePostClickEvent(
                                      postId: post.postId,
                                      currentUserId: appUser.id));
                            } else {
                              post.likes.add(appUser.id);
                              context.read<LikePostBloc>().add(
                                  LikePostClickEvent(
                                      postId: post.postId,
                                      currentUserId: appUser.id));
                            }
                          },
                          child: Icon(
                              size: 25,
                              post.likes.contains(appUser.id)
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: post.likes.contains(appUser.id)
                                  ? AppDarkColor().iconSecondarycolor
                                  : AppDarkColor().iconSoftColor)),
                      AppSizedBox.sizedBox5W,
                      Text(
                        post.likes.length.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  );
                },
              ),
              // Comments
              Row(
                children: [
                  SvgPicture.asset(
                    width: 25,
                    height: 25,
                    'assets/svgs/comment.svg',
                    colorFilter: ColorFilter.mode(
                      AppDarkColor().iconSoftColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  AppSizedBox.sizedBox5W,
                  Text(
                    '26,376',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),

              Row(
                children: [
                  SvgPicture.asset(
                    width: 25,
                    height: 25,
                    'assets/svgs/send.svg',
                    colorFilter: ColorFilter.mode(
                      AppDarkColor().iconSoftColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.bookmark_add_outlined,
              size: 25,
              color: AppDarkColor().iconSoftColor,
            ))
        // Save
      ],
    );
  }
}
