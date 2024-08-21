import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/widgets/each_post/post_content_section/widgets/post_hashtag.dart';

import '../../common/expandable_text.dart';

class PostContentSection extends StatelessWidget {
  const PostContentSection(
      {super.key, this.postDesc, required this.hashtags, this.location});
  final String? postDesc;
  final List<String> hashtags;
  final String? location;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (postDesc != null || hashtags.isNotEmpty) AppSizedBox.sizedBox5H,
        if (postDesc != null && postDesc!.isNotEmpty)
          ExpandableText(text: postDesc ?? '', trimLines: 2),
        if (postDesc != null) AppSizedBox.sizedBox10H,
        if (hashtags.isNotEmpty) PostHashtag(hashtags: hashtags),
      ],
    );
  }
}
