import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/utils.dart';
import 'package:video_player/video_player.dart';

class CustomPageView extends StatelessWidget {
  const CustomPageView({
    super.key,
    required this.pageController,
    this.images,
    this.selectedStatusAssets,
    this.onPagechanged,
  });
  final PageController pageController;
  final List<SelectedByte>? images;
  final List<AssetEntity>? selectedStatusAssets;
  final Function(int)? onPagechanged;
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      onPageChanged: onPagechanged,
      controller: pageController,
      itemCount: selectedStatusAssets != null
          ? selectedStatusAssets!.length
          : images!.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return images != null
            ? images![index].mediaType == MediaType.photo
                ? Image.file(images![index].selectedFile!)
                : VideoWidget(videoFile: images![index].selectedFile!)
            : AssetEntityImage(
                height: 600,
                width: double.infinity,
                selectedStatusAssets![index],
                isOriginal: false,
                thumbnailSize: const ThumbnailSize.square(500),
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
