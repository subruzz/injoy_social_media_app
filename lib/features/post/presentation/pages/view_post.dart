import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/const/app_sizedbox.dart';
import 'package:social_media_app/core/extensions/time_stamp_to_string.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/post/post_action_bar.dart';
import 'package:social_media_app/core/widgets/post/post_owner_image.dart';
import 'package:social_media_app/core/widgets/post/post_option_button.dart';
import 'package:social_media_app/core/widgets/post/post_description.dart';
import 'package:social_media_app/core/widgets/post/post_hashtag.dart';
import 'package:social_media_app/core/widgets/post/post_multiple_images.dart';
import 'package:social_media_app/core/widgets/post/post_single_image.dart';

class ViewPost extends StatelessWidget {
  final PostEntity post;
  const ViewPost({super.key, required this.post, this.isEdit = false});
  final bool isEdit;
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
                      PostOwnerImage(ownerImage: post.userProfileUrl),
                      AppSizedBox.sizedBox5W,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.userFullName,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text(
                            '@${post.username}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: AppDarkColor().primaryTextBlur),
                          )
                        ],
                      ),
                      const Spacer(),
                      PostOptionButton(
                        isEdit: isEdit,
                      ),
                    ],
                  ),
                  AppSizedBox.sizedBox10H,
                  if (post.description != null)
                    PostDescription(
                      description: post.description ?? '',
                      seeFull: true,
                    ),
                  if (post.hashtags.isNotEmpty) Text(post.hashtags.join('#')),
                  AppSizedBox.sizedBox10H,
                  if (post.hashtags.isNotEmpty)
                    PostHashtag(hashtags: post.hashtags),
                  if (post.postImageUrl.isNotEmpty)
                    if (post.postImageUrl.isNotEmpty)
                      post.postImageUrl.length == 1
                          ? PostSingleImage(
                              imgUrl: post.postImageUrl[0],
                              size: .5,
                            )
                          : PostMultipleImages(
                              postImageUrls: post.postImageUrl,
                              size: .5,
                            ),
                  AppSizedBox.sizedBox10H,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(post.createAt.toDate().toCustomFormat()),
                       PostActionBar(post: post,),
                    ],
                  ),
                  const Divider(),
                  AppSizedBox.sizedBox20H,
                  if (!post.isCommentOff)
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 25,
                        ),
                        AppSizedBox.sizedBox5W,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'sarah_virsson',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Text(
                              '@sarah',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      color: AppDarkColor().primaryTextBlur),
                            )
                          ],
                        )
                      ],
                    ),
                  AppSizedBox.sizedBox5H,
                  if (!post.isCommentOff)
                    const Text(
                        'how many paragraphs are enough, and how many are too many? For historical writing, there should be between four and six paragraphs in a two-page paper, or ..'),
                  if (!post.isCommentOff)
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
          if (!post.isCommentOff)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                color:
                    Colors.black, // Set the background color of the container
                child: Row(
                  children: [
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

                            fillColor:
                                AppDarkColor().background // Background color
                            ),
                      ),
                    ),
                    SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        // Handle posting comment logic here
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
