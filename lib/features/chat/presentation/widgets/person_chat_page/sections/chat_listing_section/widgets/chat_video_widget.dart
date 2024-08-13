import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:social_media_app/core/const/app_config/app_border_radius.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/const/extensions/video_duration.dart';
import 'package:social_media_app/core/theme/widget_themes/text_theme.dart';
import 'package:social_media_app/core/widgets/app_related/app_svg.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:video_player/video_player.dart';

class CachedVideoMessageWidget extends StatefulWidget {
  final String url;
  const CachedVideoMessageWidget({
    super.key,
    required this.url,
  });

  @override
  State<CachedVideoMessageWidget> createState() =>
      _CachedVideoMessageWidgetState();
}

class _CachedVideoMessageWidgetState extends State<CachedVideoMessageWidget> {
  VideoPlayerController? videoPlayerController;
  bool isPlay = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer(widget.url);
  }

  _initializePlayer(String url) async {
    final fileInfo = await checkCacheFor(url);
    if (fileInfo == null) {
      log('file is null');
      videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(widget.url))
            ..initialize().then((value) {
              cachUrl(url);
              videoPlayerController?.setVolume(1);
            });
    } else {
      final file = fileInfo.file;
      videoPlayerController = VideoPlayerController.file(file)
        ..initialize().then((value) {
          setState(() {});
          videoPlayerController?.setVolume(1);
        });
    }
  }

  //checking for cache
  Future<FileInfo?> checkCacheFor(String url) async {
    final FileInfo? value = await DefaultCacheManager().getFileFromCache(url);
    return value;
  }

  //caching the video
  void cachUrl(String url) async {
    await DefaultCacheManager().getSingleFile(url).then((value) {
      log(value.toString());
    });
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return videoPlayerController == null
        ? const CircularLoadingGrey()
        : AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(
              children: [
                (videoPlayerController!.value.isInitialized)
                    ? ClipRRect(
                        borderRadius: AppBorderRadius.small,
                        child: VideoPlayer(videoPlayerController!))
                    : const Text('loading'),
                Align(
                  alignment: Alignment.center,
                  child: IconButton(
                    onPressed: () {
                      if (isPlay) {
                        videoPlayerController?.pause();
                      } else {
                        videoPlayerController?.play();
                      }

                      setState(() {
                        isPlay = !isPlay;
                      });
                    },
                    icon: Icon(
                      isPlay
                          ? Icons.pause_circle_outline_outlined
                          : Icons.play_circle_outline_outlined,
                      size: 40,
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      children: [
                        const CustomSvgIcon(
                          height: 15,
                          assetPath: AppAssetsConst.video,
                          color: Colors.white,
                        ),
                        AppSizedBox.sizedBox5W,
                        Text(
                            style: AppTextTheme
                                .labelMediumPureWhiteVariations.labelMedium,
                            videoPlayerController!.value.duration
                                .videoFormatedDuration()),
                      ],
                    ))
              ],
            ),
          );
  }
}
