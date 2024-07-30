import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class PostFeedsOptions extends StatefulWidget {
  const PostFeedsOptions(
      {super.key,
      this.commentToggle,
      required this.icon,
      required this.text,
      this.isComment = false});
  final IconData icon;
  final String text;
  final bool isComment;
  final void Function(bool)? commentToggle;

  @override
  State<PostFeedsOptions> createState() => _PostFeedsOptionsState();
}

class _PostFeedsOptionsState extends State<PostFeedsOptions> {
  late bool commentValue;
  @override
  void initState() {
    commentValue = widget.isComment;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: AppPadding.horizontalMedium,
      leading: Icon(
        widget.icon,
        color: AppDarkColor().iconPrimaryColor,
      ),
      title: Text(widget.text),
      trailing:
          // widget.isComment
          //     ?

          Transform.scale(
        scale: .7,
        child: Switch(
          activeTrackColor: AppDarkColor().buttonBackground,
          value: commentValue,
          onChanged: (bool value) {
            setState(() {
              widget.commentToggle?.call(value);

              commentValue = value;
            });
          },
        ),
      ),
      // : Icon(Icons.arrow_forward, color: AppDarkColor().iconSecondarycolor),
      onTap: () {},
    );
  }
}
