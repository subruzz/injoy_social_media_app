import 'package:flutter/material.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/const/app_sizedbox.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/post/post_attributes.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/post/post_description.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/post/post_dot.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/post/post_hashtag.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/post/post_multiple_images.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/post/post_option_button.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/post/post_owner_image.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/post/post_owner_username.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/post/post_single_image.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/post/post_time.dart';
import 'package:social_media_app/view_post.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EachPost extends StatelessWidget {
  const EachPost({super.key, required this.currentPost});
  final PostEntity currentPost;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ViewPost(post: currentPost),
        ));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 10, bottom: 25),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PostOwnerImage(ownerImage: currentPost.userProfileUrl),
            AppSizedBox.sizedBox5W,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          PostOwnerUsername(userName: currentPost.username),
                          AppSizedBox.sizedBox5W,
                          const PostDot(),
                          AppSizedBox.sizedBox5W,
                          PostTime(postTime: currentPost.createAt.toDate()),
                        ],
                      ),
                      const PostOptionButton(),
                    ],
                  ),
                  PostDescription(description: currentPost.description ?? ''),
                  if (currentPost.hashtags.isNotEmpty)
                    PostHashtag(hashtags: currentPost.hashtags),
                  AppSizedBox.sizedBox5H,
                  if (currentPost.postImageUrl.isNotEmpty)
                    currentPost.postImageUrl.length == 1
                        ? PostSingleImage(imgUrl: currentPost.postImageUrl[0])
                        : PostMultipleImages(
                            postImageUrls: currentPost.postImageUrl),
                  if (currentPost.postImageUrl.isNotEmpty)
                    AppSizedBox.sizedBox5H,
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 35,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppDarkColor()
                            .softBackground, // Dark background color
                        borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const PostAttributes(
                              icon: Icons.favorite_border, count: 335),
                          AppSizedBox.sizedBox10W,
                          const PostAttributes(
                              icon: Icons.chat_bubble_outline, count: 98),
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
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

