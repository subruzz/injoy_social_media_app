import 'package:flutter/material.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/extensions/time_stamp_to_string.dart';
import 'package:social_media_app/core/widgets/post/post_action_bar.dart';
import 'package:social_media_app/core/widgets/post/post_description.dart';
import 'package:social_media_app/core/widgets/post/post_hashtag.dart';
import 'package:social_media_app/core/widgets/post/post_multiple_images.dart';
import 'package:social_media_app/core/widgets/post/post_single_image.dart';

class PostDetailsSection extends StatelessWidget {
  const PostDetailsSection({super.key, required this.post});
  final PostEntity post;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (post.description != null)
          PostDescription(
            description: post.description ?? '',
            seeFull: true,
          ),
        AppSizedBox.sizedBox5H,
        if (post.hashtags.isNotEmpty) PostHashtag(hashtags: post.hashtags),
        AppSizedBox.sizedBox5H,
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
        AppSizedBox.sizedBox3H,
        Text(post.createAt.toDate().toCustomFormat()),
        const Divider(),
        SocialActions(
          post: post,
          likeAnim: () {},
          isCommentNeeded: false,
        ),
        const Divider(),
        AppSizedBox.sizedBox10H,
      ],
    );
  }
}
