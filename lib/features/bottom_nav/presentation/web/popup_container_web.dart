import 'package:flutter/material.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/widgets/each_post/post_content_section/post_content_section.dart';
import 'package:social_media_app/core/widgets/each_post/post_image_section.dart/widgets/post_multiple_images.dart';
import 'package:social_media_app/core/widgets/each_post/post_top_section/post_top_details.dart';
import 'package:social_media_app/features/post/presentation/pages/comment_screen.dart';

import '../../../../core/const/app_config/web_design_const.dart';
import '../../../../core/widgets/common/video_playing_widget.dart';

class PopupContainerWeb extends StatefulWidget {
  const PopupContainerWeb({
    super.key,
    this.isShorts = false,
    required this.post,
  });

  final PostEntity post;
  final bool isShorts;

  @override
  State<PopupContainerWeb> createState() => _PopupContainerWebState();
}

class _PopupContainerWebState extends State<PopupContainerWeb> {
  final _currentPostImageIndex = ValueNotifier<int>(0);
  final _pageViewC = PageController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final isSmallScreen = screenWidth < 800;

    return Scaffold(
      backgroundColor: Colors.black38,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isThatDeskTop
                  ? 110.0
                  : isThatTab
                      ? 50
                      : 20,
              vertical: isThatDeskTop
                  ? 70.0
                  : isThatTab
                      ? 40
                      : 10,
            ),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: borderColor, width: 3),
                ),
                child: SizedBox(
                  height: isThatDeskTop ? screenWidth / 2 : screenHeight - 200,
                  width: isSmallScreen ? screenWidth * 0.9 : 1270,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isSmallScreen)
                        Flexible(
                          flex: 2,
                          child: Stack(
                          
                            children: [
                              Container(
                                height: double.infinity,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    topLeft: Radius.circular(5),
                                  ),
                                  color: Colors.black,
                                ),
                                child: widget.post.isThatvdo
                                    ? VideoPlayerWidget(
                                        reel: widget.post,
                                        onlyVdo: true,
                                      )
                                    : PostMultipleImages(
                                        postImageUrls: widget.post.postImageUrl,
                                        pageController: _pageViewC,
                                      ),
                              ),
                              if (widget.post.postImageUrl.length > 1)
                                ValueListenableBuilder<int>(
                                  valueListenable: _currentPostImageIndex,
                                  builder: (context, value, child) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if (value > 0)
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: GestureDetector(
                                              onTap: () {
                                                _currentPostImageIndex.value =
                                                    value - 1;
                                                _pageViewC.animateToPage(
                                                  _currentPostImageIndex.value,
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  curve: Curves.easeInOut,
                                                );
                                              },
                                              child: const Icon(
                                                  Icons.chevron_left_outlined),
                                            ),
                                          ),
                                        if (value <
                                            widget.post.postImageUrl.length - 1)
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: GestureDetector(
                                              onTap: () {
                                                _currentPostImageIndex.value =
                                                    value + 1;
                                                _pageViewC.animateToPage(
                                                  _currentPostImageIndex.value,
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  curve: Curves.easeInOut,
                                                );
                                              },
                                              child: const Icon(
                                                  Icons.chevron_right_sharp),
                                            ),
                                          ),
                                      ],
                                    );
                                  },
                                )
                            ],
                          ),
                        ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            border: Border(
                              left: BorderSide(
                                color: borderColor,
                                width: 2.0, // Adjust the width as needed
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 13.0),
                                child: PostTopDetails(
                                  post: widget.post,
                                  pagecontroller: _pageViewC,
                                  currentPostIndex: 0,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 13.0),
                                child: PostContentSection(
                                  hashtags: widget.post.hashtags,
                                  postDesc: widget.post.description,
                                ),
                              ),
                              Expanded(
                                child: CommentScreen(
                                  post: widget.post,
                                  onCommentAction: (num num) {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          closeButton(),
        ],
      ),
    );
  }

  Padding closeButton() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).maybePop();
        },
        child: const Align(
          alignment: Alignment.topRight,
          child: Icon(
            Icons.close_rounded,
            size: 26,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget imageOfPost(PostEntity post) {
    return PostMultipleImages(
      postImageUrls: post.postImageUrl,
      pageController: _pageViewC,
    );
  }
}
