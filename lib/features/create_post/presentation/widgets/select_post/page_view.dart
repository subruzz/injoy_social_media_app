import 'dart:io';

import 'package:flutter/material.dart';
import 'package:social_media_app/features/create_post/presentation/widgets/hashtags/search_hashtag.dart';

class PageViewPosts extends StatelessWidget {
  const PageViewPosts(
      {super.key,
      required this.pageController,
      required this.images,
    });
  final PageController pageController;
  final List<File?> images;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: pageController,
        itemCount: images.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return CreatePostImage(
              onTap: () {
                //  context.read<PickMultipleImageCubit>().removeImage(images[index]);
              },
              selectedImage: images[index]);
        },
      ),
    );
  }
}
