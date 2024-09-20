import 'package:flutter/material.dart';
import 'package:social_media_app/features/post/presentation/widgets/create_post/section/post_option_section/widgets/post_feeds_options.dart';

import '../../../../../../../core/utils/extensions/localization.dart';

class PostOptionSection extends StatelessWidget {
  const PostOptionSection(
      {super.key,
      required this.isCommentOff,
      this.onCommentToggle,
      required this.l10n});
  final bool isCommentOff;
  final void Function(bool)? onCommentToggle;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // const PostFeedsOptions(
        //     icon: Icons.person_add_alt_outlined, text: 'Tag People'),
        // AppSizedBox.sizedBox10H,
        //  PostFeedsOptions(
        //     icon: Icons.visibility_outlined, text: 'Audience'),
        PostFeedsOptions(
            commentToggle: onCommentToggle,
            isComment: isCommentOff,
            icon: Icons.comment,
            text: l10n.turnOffComments),
      ],
    );
  }
}
