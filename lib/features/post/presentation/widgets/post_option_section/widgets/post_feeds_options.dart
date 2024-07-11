import 'package:flutter/material.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

final ValueNotifier<bool> isCommentOff = ValueNotifier(false);

class PostFeedsOptions extends StatelessWidget {
  const PostFeedsOptions(
      {super.key,
      required this.icon,
      required this.text,
      this.isComment = false});
  final IconData icon;
  final String text;
  final bool isComment;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppDarkColor().iconSoftColor,
      ),
      title: Text(text),
      trailing: isComment
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
        // Handle tag people
      },
    );
  }
}
