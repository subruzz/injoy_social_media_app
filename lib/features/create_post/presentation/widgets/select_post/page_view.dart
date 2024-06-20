import 'dart:io';

import 'package:flutter/material.dart';
import 'package:social_media_app/core/shared_providers/cubits/Pick_multiple_image/pick_multiple_image_cubit.dart';
import 'package:social_media_app/features/create_post/presentation/widgets/hashtags/search_hashtag.dart';

class PageViewPosts extends StatelessWidget {
  const PageViewPosts(
      {super.key,
      required this.pageController,
      required this.images,
      required this.pickMultipleImageCubit});
  final PageController pageController;
  final List<File?> images;
  final PickMultipleImageCubit pickMultipleImageCubit;
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
                pickMultipleImageCubit.removeImage(images[index]);
              },
              selectedImage: images[index]);
        },
      ),
    );
  }
}
