import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/common/entities/post.dart';
import '../../../../core/widgets/common/video_playing_widget.dart';

class VideoPageView extends StatelessWidget {
  const VideoPageView({
    super.key,
    required this.controller,
    required this.reels,
    required this.onChaged,
    this.isItFromBottomBar = false,
    this.onCommentClick,
    this.vdoController,
    this.onPause,this.isItMine=false,
  });
  final PageController controller;
  final bool isItFromBottomBar;
  final void Function(void Function())? onPause;

  final List<PostEntity> reels;
  final void Function(int) onChaged;
  final void Function(PostEntity)? onCommentClick;
  final VideoPlayerController? vdoController;
final bool isItMine;
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      controller: controller,
      itemCount: reels.length,
      onPageChanged: (index) {
        onChaged(index);
      },
      itemBuilder: (context, index) {
        return VideoPlayerWidget(
          isItMine: isItMine,
          currentIndex: index,
          pageController: controller,
          onPause: onPause,
          isItFromBottomBar: isItFromBottomBar,
          vdoController: vdoController,
          onCommentClick: onCommentClick,
          reel: reels[index],
          key: Key(reels[index].postImageUrl.first),
        );
      },
    );
  }
}
