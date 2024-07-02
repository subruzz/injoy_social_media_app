import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:social_media_app/features/post/presentation/widgets/hashtags/search_hashtag.dart';

class CustomPageView extends StatelessWidget {
  const CustomPageView({
    super.key,
    required this.pageController,
    this.images,
    this.selectedStatusAssets,
  });
  final PageController pageController;
  final List<File?>? images;
  final List<AssetEntity>? selectedStatusAssets;
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      itemCount: selectedStatusAssets != null
          ? selectedStatusAssets!.length
          : images!.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return selectedStatusAssets != null
            ? AssetEntityImage(
                height: 600,
                width: double.infinity,
                selectedStatusAssets![index],
                isOriginal: false,
                thumbnailSize: const ThumbnailSize.square(500),
              )
            : CreatePostImage(
                onTap: () {
                  //  context.read<PickMultipleImageCubit>().removeImage(images[index]);
                },
                selectedImage: images![index]);
      },
    );
  }
}
