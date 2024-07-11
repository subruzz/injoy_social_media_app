import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/extensions/time_stamp_to_string.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/post/post_action_bar.dart';
import 'package:social_media_app/core/widgets/post/post_owner_image.dart';
import 'package:social_media_app/core/widgets/post/post_option_button.dart';
import 'package:social_media_app/core/widgets/post/post_description.dart';
import 'package:social_media_app/core/widgets/post/post_hashtag.dart';
import 'package:social_media_app/core/widgets/post/post_multiple_images.dart';
import 'package:social_media_app/core/widgets/post/post_single_image.dart';
import 'package:social_media_app/core/widgets/user_profile.dart';
import 'package:social_media_app/features/post/presentation/bloc/comment_cubits/comment_basic_action/comment_basic_cubit.dart';
import 'package:social_media_app/features/post/presentation/bloc/comment_cubits/get_post_comment/get_post_comment_cubit.dart';

class ViewPost extends StatefulWidget {
  final PostEntity post;
  const ViewPost({super.key, required this.post, this.isEdit = false});
  final bool isEdit;

  @override
  State<ViewPost> createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  @override
  void initState() {
    context
        .read<GetPostCommentCubit>()
        .getPostComments(postId: widget.post.postId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      PostOwnerImage(ownerImage: widget.post.userProfileUrl),
                      AppSizedBox.sizedBox5W,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.post.userFullName,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text(
                            '@${widget.post.username}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: AppDarkColor().primaryTextBlur),
                          )
                        ],
                      ),
                      PostOptionButton(
                        isEdit: widget.isEdit,
                      ),
                    ],
                  ),
                  AppSizedBox.sizedBox10H,
                  if (widget.post.description != null)
                    PostDescription(
                      description: widget.post.description ?? '',
                      seeFull: true,
                    ),
                  if (widget.post.hashtags.isNotEmpty)
                    Text(widget.post.hashtags.join('#')),
                  AppSizedBox.sizedBox10H,
                  if (widget.post.hashtags.isNotEmpty)
                    PostHashtag(hashtags: widget.post.hashtags),
                  if (widget.post.postImageUrl.isNotEmpty)
                    if (widget.post.postImageUrl.isNotEmpty)
                      widget.post.postImageUrl.length == 1
                          ? PostSingleImage(
                              imgUrl: widget.post.postImageUrl[0],
                              size: .5,
                            )
                          : PostMultipleImages(
                              postImageUrls: widget.post.postImageUrl,
                              size: .5,
                            ),
                  AppSizedBox.sizedBox10H,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.post.createAt.toDate().toCustomFormat()),
                      //  PostActionBar(post: post,),
                    ],
                  ),
                  const Divider(),
                  AppSizedBox.sizedBox20H,
                  if (!widget.post.isCommentOff)
                    BlocBuilder<GetPostCommentCubit, GetPostCommentState>(
                      builder: (context, state) {
                        if (state is GetPostCommentSuccess) {
                          log('we have this much comments ${state.postComments.length}');
                          return SizedBox(
                            height:
                                300, // Constrain the height of ListView.builder
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: state.postComments.length,
                              itemBuilder: (context, index) => Column(
                                children: [
                                  Row(
                                    children: [
                                      const CircleAvatar(
                                        radius: 25,
                                      ),
                                      AppSizedBox.sizedBox5W,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'sarah_virsson',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          ),
                                          Text(
                                            '@sarah',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                    color: AppDarkColor()
                                                        .primaryTextBlur),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  AppSizedBox.sizedBox5H,
                                  if (!widget.post.isCommentOff)
                                    const Text(
                                        'how many paragraphs are enough, and how many are too many? For historical writing, there should be between four and six paragraphs in a two-page paper, or ..'),
                                ],
                              ),
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                  if (!widget.post.isCommentOff)
                    Row(
                      children: [
                        _buildIconWithCount(Icons.favorite, 435, Colors.red),
                        AppSizedBox.sizedBox10W,
                        TextButton(
                            onPressed: () {}, child: const Text('Reply')),
                        AppSizedBox.sizedBox10W,
                        const Text('5 hours ago')
                      ],
                    ),
                ],
              ),
            ),
          ),
          if (!widget.post.isCommentOff)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 80,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                color:
                    Colors.black, // Set the background color of the container
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                    
                      ],
                    ),
                    Row(
                      children: [
                        CircularUserProfile(
                          size: 12,
                        ),
                        Expanded(
                          child: TextField(
                            style: TextStyle(color: Colors.white), // Text color
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Write a comment...',
                                enabledBorder: InputBorder.none,
                                filled: true,
                                focusedBorder:
                                    InputBorder.none, // No border when focused

                                fillColor: AppDarkColor()
                                    .background // Background color
                                ),
                          ),
                        ),
                        SizedBox(width: 10),
                        TextButton(
                          onPressed: () {
                            final user = context.read<AppUserBloc>().appUser;
                            context.read<CommentBasicCubit>().addComment(
                                comment: 'comment',
                                userName: user.userName ?? '',
                                postId: widget.post.postId,
                                creatorId: user.id);
                                
                          },
                          child: Text(
                            'Post',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge, // Button text color
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

Widget _buildIconWithCount(IconData icon, int count, [Color? iconColor]) {
  return Row(
    children: [
      Icon(
        icon,
        size: 18,
        color: iconColor ?? Colors.white,
      ),
      const SizedBox(width: 5),
      Text(
        count.toString(),
        style: const TextStyle(fontSize: 12, color: Colors.white),
      ),
    ],
  );
}
