import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_sizedbox.dart';
import 'package:social_media_app/core/widgets/post/post_attributes.dart';

class PostActionBar extends StatelessWidget {
  const PostActionBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const PostAttributes(icon: Icons.favorite_border, count: 335),
        AppSizedBox.sizedBox10W,
        const PostAttributes(icon: Icons.chat_bubble_outline, count: 98),
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
    );
  }
}
