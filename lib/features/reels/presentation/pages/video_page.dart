import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/common/each_post/post_action_section/widgets/post_comment_button.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/common/each_post/post_action_section/widgets/post_like_button.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/add_at_symbol.dart';
import '../../../../core/app_error_gif.dart';
import '../../../../core/common/models/partial_user_model.dart';
import '../../../../core/const/app_config/app_sizedbox.dart';
import '../../../../core/services/app_cache/cache_manager.dart';
import '../../../../core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import '../../../../core/widgets/expandable_text.dart';
import '../../../../core/widgets/follow_unfollow_helper.dart';
import '../../../../core/widgets/user_profile.dart';
import '../bloc/reels/reels_cubit.dart';

class VideoReelPage extends StatefulWidget {
  const VideoReelPage({super.key, this.reels, this.index = 0});
  final List<PostEntity>? reels;

  final int index;

  @override
  State<VideoReelPage> createState() => _VideoReelPageState();
}

class _VideoReelPageState extends State<VideoReelPage> {
  late PageController _pageController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.index);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: widget.reels != null
          ? ReelsPageView(
              controller: _pageController,
              reels: widget.reels!,
              onChaged: (index) {
                currentPage = index;
              })
          : BlocBuilder<ReelsCubit, ReelsState>(
              builder: (context, state) {
                if (state is ReelsFailure) {
                  return const AppErrorGif();
                }
                if (state is ReelsSuccess) {
                  return ReelsPageView(
                      controller: _pageController,
                      reels: state.reels,
                      onChaged: (index) {
                        if (index == state.reels.length - 1 &&
                            state.lastDocument != null) {
                          context
                              .read<ReelsCubit>()
                              .getReels('i', isInitialLoad: false);
                        }
                        currentPage = index;
                      });
                }
                return loadingWidget();
              },
            ),
    );
  }
}

Widget loadingWidget() {
  return Stack(
    children: [
      Shimmer.fromColors(
        baseColor: Colors.grey[500]!,
        highlightColor: const Color(0xFFAFAFAF),
        child: Container(
          width: double.infinity,
          height: double.maxFinite,
          color: Colors.grey,
        ),
      ),
      Shimmer.fromColors(
        baseColor: Colors.grey[600]!,
        highlightColor: const Color(0xFFAFAFAF),
        child: Padding(
          padding: const EdgeInsetsDirectional.only(
              end: 25.0, bottom: 20, start: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xff282828),
              ),
              const SizedBox(height: 5),
              Container(height: 15, width: 150, color: const Color(0xff282828)),
              const SizedBox(height: 5),
              Container(height: 15, width: 200, color: const Color(0xff282828)),
            ],
          ),
        ),
      ),
    ],
  );
}

class ReelsPageView extends StatelessWidget {
  const ReelsPageView(
      {super.key,
      required this.controller,
      required this.reels,
      required this.onChaged});
  final PageController controller;
  final List<PostEntity> reels;
  final void Function(int) onChaged;
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
          reel: reels[index],
          key: Key(reels[index].postImageUrl.first),
        );
      },
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final PostEntity reel;

  const VideoPlayerWidget({
    super.key,
    required this.reel,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget>
    with WidgetsBindingObserver {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initializeController();
  }

  bool _videoInitialized = false;

  initializeController() async {
    var fileInfo =
        await kCacheManager.getFileFromCache(widget.reel.postImageUrl.first);
    if (fileInfo == null) {
      await kCacheManager.downloadFile(widget.reel.postImageUrl.first);
      fileInfo =
          await kCacheManager.getFileFromCache(widget.reel.postImageUrl.first);
    }
    if (mounted) {
      _controller = VideoPlayerController.file(fileInfo!.file)
        ..initialize().then((_) {
          setState(() {
            _controller.setLooping(true); // Set video to loop
            _controller.play();
            _videoInitialized = true;
          });
        });
      _controller.addListener(() {
        if (_controller.value.isPlaying && !_isPlaying) {
          // Video has started playing
          setState(() {
            _isPlaying = true;
          });
        }
      });
    }
  }

  bool _isPlaying = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // App is in the foreground
      _controller.play();
    } else if (state == AppLifecycleState.inactive) {
      // App is partially obscured
      _controller.pause();
    } else if (state == AppLifecycleState.paused) {
      // App is in the background
      _controller.pause();
    } else if (state == AppLifecycleState.detached) {
      // App is terminated
      _controller.dispose();
    }
  }


  @override
  void dispose() {
    if (mounted) {
      _controller.dispose();
    } // Dispose of the controller when done
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final me = context.read<AppUserBloc>().appUser;

    return SafeArea(
      top: false,
      left: false,
      right: false,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              if (_videoInitialized) {
                setState(() {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                    _isPlaying = false;
                  } else {
                    _controller.play();
                    _isPlaying = true;
                  }
                });
              }
            },
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                !_videoInitialized
                    // when the video is not initialized you can set a thumbnail.
                    // to make it simple, I use CircularProgressIndicator
                    ? Image.network(
                        widget.reel.extra!,
                        width: double.infinity,
                        height: 1.h,
                      )
                    : VideoPlayer(_controller),
                !_videoInitialized
                    ? Image.network(
                        widget.reel.extra!,
                        width: double.infinity,
                        height: 1.h,
                      )
                    : const SizedBox(),
                if (!_isPlaying)
                  const Center(
                    child: Icon(
                      Icons.play_arrow,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                !_videoInitialized
                    ? const SizedBox()
                    : VideoProgressIndicator(
                        _controller,
                        allowScrubbing: true,
                        colors: VideoProgressColors(
                          playedColor: AppDarkColor().buttonBackground,
                          bufferedColor: Colors.grey,
                          backgroundColor: Colors.white,
                        ),
                      ),
                Positioned(
                  bottom: 20,
                  left: 10,
                  right: 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircularUserProfile(
                              size: 22, profile: widget.reel.userProfileUrl),
                          AppSizedBox.sizedBox10W,
                          Text(
                            addAtSymbol(widget.reel.username),
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          AppSizedBox.sizedBox10W,
                          if (widget.reel.creatorUid != me.id)
                            FollowUnfollowHelper(
                                wantWhiteBorder: true,
                                color: Colors.transparent,
                                noRad: true,
                                user: PartialUser(id: widget.reel.creatorUid))
                        ],
                      ),
                      AppSizedBox.sizedBox10H,
                      Column(
                        children: [
                          ExpandableText(
                              text: widget.reel.description ?? '', trimLines: 2)
                        ],
                      )
                    ],
                  ),
                ),
                // Positioned(

                // Action Buttons positioned at the bottom right
                Positioned(
                  right: 10,
                  bottom: 200.h,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Like Button
                      PostLikeButton(
                        me: me,
                        post: widget.reel,
                        isReel: true,
                      ),
                      AppSizedBox.sizedBox20H,
                      PostCommentButton(
                        post: widget.reel,
                        isReel: true,
                      ),
                      // Share Button
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
