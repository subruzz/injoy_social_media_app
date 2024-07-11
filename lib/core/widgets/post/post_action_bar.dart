import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/like_post/like_post_bloc.dart';

class SocialActions extends StatelessWidget {
  const SocialActions({super.key, required this.post, required this.likeAnim});
  final PostEntity post;
  final VoidCallback likeAnim;

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
                              likeAnim();
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
