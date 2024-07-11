import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/features/post/presentation/widgets/post_option_section/widgets/post_feeds_options.dart';

class PostOptionSection extends StatelessWidget {
  const PostOptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PostFeedsOptions(
            icon: Icons.person_add_alt_outlined, text: 'Tag People'),
        AppSizedBox.sizedBox10H,
        const PostFeedsOptions(
            icon: Icons.visibility_outlined, text: 'Audience'),
        const PostFeedsOptions(
            isComment: true, icon: Icons.comment, text: 'Turn off Comment'),
      ],
    );
  }
}
