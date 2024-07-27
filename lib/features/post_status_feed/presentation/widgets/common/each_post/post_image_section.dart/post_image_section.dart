import 'package:flutter/material.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/common/each_post/post_image_section.dart/widgets/post_multiple_images.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/common/each_post/post_image_section.dart/widgets/post_single_image.dart';

class PostImageSection extends StatelessWidget {
  const PostImageSection({super.key, required this.postImages});
  final List<String> postImages;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (postImages.isNotEmpty)
          postImages.length == 1
              ? PostSingleImage(imgUrl: postImages[0])
              : PostMultipleImages(postImageUrls: postImages),
      ],
    );
  }
}
