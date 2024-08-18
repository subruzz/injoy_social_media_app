import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/utils/responsive/responsive_helper.dart';
import 'package:social_media_app/core/widgets/common/cached_image.dart';
import 'package:social_media_app/features/post/presentation/widgets/edit_post/edit_screen_feed_option.dart';

import '../../../common/view_media.dart';

class PostMultipleImages extends StatelessWidget {
  const PostMultipleImages(
      {super.key,
      required this.postImageUrls,
      this.size = .4,
      this.isEdit = false,
      required this.pageController});
  final bool isEdit;
  final List<String> postImageUrls;
  final double size;
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Responsive.deskTopAndTab(context) ? size : size.sh,
      width: double.infinity,
      child: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: postImageUrls.length,
            itemBuilder: (context, index) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ViewMedia(
                              assets: postImageUrls, initialIndex: index),
                        ));
                      },
                      child: CachedImage(
                          fit: isThatTabOrDeskTop ? BoxFit.contain : null,
                          img: postImageUrls[index])),
                  if (postImageUrls.length > 1)
                    Positioned(
                        top: 2,
                        left: 2,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                style: const TextStyle(fontSize: 8),
                                '${index + 1}/${postImageUrls.length}'),
                          ),
                        )),
                ],
              );
            },
          ),
          // if (isEdit)
          //   const Positioned(
          //       bottom: 10,
          //       left: 10,
          //       child: EditScreenFeedOption(
          //           title: 'Tag People', icon: Icons.people_outline_outlined)),
          // if (isEdit)
          //   const Positioned(
          //       bottom: 10,
          //       right: 10,
          //       child: EditScreenFeedOption(
          //           title: 'Audience', icon: Icons.visibility))
        ],
      ),
    );
  }
}
