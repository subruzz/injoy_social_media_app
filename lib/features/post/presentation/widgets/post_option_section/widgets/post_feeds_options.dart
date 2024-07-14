import 'package:flutter/material.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/features/post/presentation/pages/tag_people.dart';

final ValueNotifier<bool> isCommentOff = ValueNotifier(false);

class PostFeedsOptions extends StatefulWidget {
  const PostFeedsOptions(
      {super.key,
      required this.icon,
      required this.text,
      this.isComment = false});
  final IconData icon;
  final String text;
  final bool isComment;

  @override
  State<PostFeedsOptions> createState() => _PostFeedsOptionsState();
}

class _PostFeedsOptionsState extends State<PostFeedsOptions> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        widget.icon,
        color: AppDarkColor().iconSoftColor,
      ),
      title: Text(widget.text),
      trailing: widget.isComment
          ? Transform.scale(
              scale: .7,
              child: ValueListenableBuilder(
                valueListenable: isCommentOff,
                builder: (context, value, child) => Switch(
                  activeTrackColor: AppDarkColor().buttonBackground,
                  value: isCommentOff.value,
                  onChanged: (bool value) {
                    isCommentOff.value = value;
                  },
                ),
              ),
            )
          : const Icon(Icons.arrow_forward, color: Colors.grey),
      onTap: () {
      
      },
    );
  }
}
