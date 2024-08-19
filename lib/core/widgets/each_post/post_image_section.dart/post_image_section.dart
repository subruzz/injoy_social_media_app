import 'package:flutter/material.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/utils/responsive/responsive_helper.dart';
import 'package:social_media_app/core/widgets/each_post/post_image_section.dart/widgets/post_multiple_images.dart';

class PostImageSection extends StatelessWidget {
  const PostImageSection(
      {super.key, required this.postImages, required this.pagecontroller});
  final List<String> postImages;
  final PageController pagecontroller;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => ViewMedia(
        //       assets: widget.currentPost.postImageUrl,
        //       initialIndex: initialIndex),
        // ));
      },
      child: Column(
        children: [
          if (postImages.isNotEmpty)
            PostMultipleImages(
              size: Responsive.isBtwMobAndTab(context)
                  ? 550
                  : isThatDeskTop||!isThatMobile
                      ? 450
                      : .4,
              postImageUrls: postImages,
              pageController: pagecontroller,
            ),
        ],
      ),
    );
  }
}
