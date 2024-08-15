import 'package:flutter/material.dart';
import 'package:social_media_app/core/widgets/common/cached_image.dart';

import 'package:social_media_app/features/post/presentation/widgets/edit_post/edit_screen_feed_option.dart';

class PostSingleImage extends StatelessWidget {
  const PostSingleImage(
      {super.key, required this.imgUrl, this.size = .4, this.isEdit = false});
  final String imgUrl;
  final double size;
  final bool isEdit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedImage(
          img: imgUrl,
          size: size,
        ),
        if (isEdit)
          const Positioned(
              bottom: 10,
              left: 10,
              child: EditScreenFeedOption(
                  title: 'Tag People', icon: Icons.people_outline_outlined)),
        if (isEdit)
          const Positioned(
              bottom: 10,
              right: 10,
              child: EditScreenFeedOption(
                  title: 'Audience', icon: Icons.visibility))
      ],
    );
  }
}
