import 'package:flutter/material.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class PostOptionButton extends StatelessWidget {
  const PostOptionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: IconButton(
        onPressed: () {},
        icon: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppDarkColor().secondaryBackground),
          child: const Padding(
            padding: EdgeInsets.all(2.0),
            child: Icon(Icons.more_horiz_rounded),
          ),
        ),
      ),
    );
  }
}
