import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/features/post/presentation/bloc/comment_cubits/comment_basic_action/comment_basic_cubit.dart';
import 'package:social_media_app/features/post/presentation/bloc/comment_cubits/get_post_comment/get_post_comment_cubit.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/like_post/like_post_bloc.dart';
import 'package:social_media_app/features/post/presentation/pages/comment_screen.dart';

class SocialActions extends StatelessWidget {
  const SocialActions(
      {super.key,
      this.isCommentNeeded = true,
      required this.post,
      required this.likeAnim});
  final PostEntity post;
  final VoidCallback likeAnim;
  final bool isCommentNeeded;
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
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
                  AppSizedBox.sizedBox20W,
                  // Comments
                  if (isCommentNeeded)
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context
                                .read<GetPostCommentCubit>()
                                .getPostComments(postId: post.postId);
                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => CommentScreen(
                                      post: post,
                                    ));
                          },
                          child: SvgPicture.asset(
                            width: 24,
                            height: 24,
                            'assets/svgs/comment.svg',
                            colorFilter: ColorFilter.mode(
                              AppDarkColor().iconSoftColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        AppSizedBox.sizedBox5W,
                        BlocBuilder<CommentBasicCubit, CommentBasicState>(
                          buildWhen: (previous, current) =>
                              current is CommentDeletedSuccess ||
                              current is CommentAddedSuccess,
                          builder: (context, state) {
                            log('builded');
                            return Builder(builder: (context) {
                              log('builder called ${post.username}');
                              return Text(
                                post.totalComments.toString(),
                                style: TextStyle(color: Colors.white),
                              );
                            });
                          },
                        ),
                      ],
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
        // IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.bookmark_add_outlined,
        //       size: 25,
        //       color: AppDarkColor().iconSoftColor,
        //     ))
        // Save
      ],
    );
  }
}
