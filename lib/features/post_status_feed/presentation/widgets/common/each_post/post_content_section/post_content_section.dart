import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/common/each_post/post_content_section/widgets/post_description.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/common/each_post/post_content_section/widgets/post_hashtag.dart';

class PostContentSection extends StatelessWidget {
  const PostContentSection({super.key, this.postDesc, required this.hashtags});
  final String? postDesc;
  final List<String> hashtags;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSizedBox.sizedBox5H,
        if (postDesc != null) PostDescription(description: postDesc ?? ''),
        if (postDesc != null) AppSizedBox.sizedBox3H,
        if (hashtags.isNotEmpty) PostHashtag(hashtags: hashtags),
      ],
    );
  }
}
