import 'dart:io';

import 'package:flutter/material.dart';
import 'package:social_media_app/core/widgets/common/cached_image.dart';
import 'package:social_media_app/core/services/assets/asset_model.dart';
import 'package:social_media_app/core/widgets/common/video_playing_widget.dart';
import 'package:video_player/video_player.dart';

class CustomPageView extends StatelessWidget {
  const CustomPageView({
    super.key,
    required this.pageController,
    this.images,
    this.netImages,
    this.onPagechanged,
    this.fit,
    this.isThatVdo = false,
  });
  final PageController pageController;
  final List<SelectedByte>? images;
  final List<String>? netImages;
  final Function(int)? onPagechanged;
  final BoxFit? fit;
  final bool isThatVdo;
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      onPageChanged: onPagechanged,
      controller: pageController,
      itemCount: netImages != null ? netImages!.length : images!.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return images != null
            ? images![index].mediaType == MediaType.photo
                ? Image.file(images![index].selectedFile)
                : VideoWidget(videoFile: images![index].selectedFile)
            : isThatVdo
                ? Center(
                  child: VideoPlayerWidget(
                      onlyVdo: true,
                      vdo: netImages!.first,
                    ),
                )
                : CachedImage(
                    img: netImages![index],
                    fit: fit,
                  );
        // : CreatePostImage(
        //     onTap: () {
        //       //  context.read<PickMultipleImageCubit>().removeImage(images[index]);
        //     },
        //     selectedImage: images![index]);
      },
    );
  }
}

class VideoWidget extends StatefulWidget {
  final File videoFile;
  const VideoWidget({super.key, required this.videoFile});

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;

  bool isPlay = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.videoFile)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : Container(),
        Align(
          alignment: Alignment.center,
          child: IconButton(
            onPressed: () {
              if (isPlay) {
                _controller.pause();
              } else {
                _controller.play();
              }

              setState(() {
                isPlay = !isPlay;
              });
            },
            icon: Icon(
              isPlay ? Icons.pause_circle : Icons.play_circle,
              size: 40,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
