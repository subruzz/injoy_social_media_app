import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/const/extensions/video_duration.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/utils/di/init_dependecies.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/widgets/app_related/common_text.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/features/bottom_nav/presentation/cubit/bottom_bar_cubit.dart';
import 'package:social_media_app/features/explore/presentation/blocs/reels_explore/reels_explore_cubit.dart';
import 'package:social_media_app/core/widgets/each_post/post_action_section/widgets/post_comment_button.dart';
import 'package:social_media_app/core/widgets/each_post/post_action_section/widgets/post_like_button.dart';
import 'package:social_media_app/features/reels/domain/usecases/get_reels.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/const/assets/app_assets.dart';
import '../../../../core/theme/widget_themes/text_theme.dart';
import '../../../../core/widgets/app_related/app_svg.dart';
import '../../../../core/widgets/common/add_at_symbol.dart';
import '../../../../core/widgets/common/app_error_gif.dart';
import '../../../../core/common/models/partial_user_model.dart';
import '../../../../core/const/app_config/app_sizedbox.dart';
import '../../../../core/services/app_cache/cache_manager.dart';
import '../../../../core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import '../../../../core/widgets/common/expandable_text.dart';
import '../../../../core/widgets/helper/follow_unfollow_helper.dart';
import '../../../../core/widgets/common/user_profile.dart';
import '../bloc/reels/reels_cubit.dart';

class VideoReelPage extends StatefulWidget {
  const VideoReelPage(
      {super.key,
      this.reels,
      this.showOne = false,
      this.index = 0,
      this.isItFromBottomBar = false,
      this.short,
      this.onCommentClick,
      this.vdoController,
      this.onPause});
  final List<PostEntity>? reels;
  final void Function(PostEntity)? onCommentClick;
  final VideoPlayerController? vdoController;
  final bool isItFromBottomBar;
  final bool showOne;
  final int index;
  final PostEntity? short;
  final void Function(void Function())? onPause;

  @override
  State<VideoReelPage> createState() => _VideoReelPageState();
}

class _VideoReelPageState extends State<VideoReelPage> {
  late PageController _pageController;
  int currentPage = 0;
  @override
  void initState() {
    log('video widget build');
    super.initState();
    _pageController = PageController(initialPage: widget.index);
  }

  @override
  void dispose() {
    log('video widget dispose');
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: widget.short != null && widget.showOne
          ? VideoPlayerWidget(
              reel: widget.short!,
              onCommentClick: widget.onCommentClick,
            )
          : widget.reels != null
              ? ReelsPageView(
                  onCommentClick: widget.onCommentClick,
                  controller: _pageController,
                  reels: widget.reels!,
                  onChaged: (index) {
                    currentPage = index;
                  })
              : widget.short != null
                  ? BlocProvider(
                      create: (context) => ReelsExploreCubit(
                          serviceLocator<GetReelsUseCase>(), widget.short!)
                        ..getReels(context.read<AppUserBloc>().appUser.id,
                            widget.short!.postId),
                      child: BlocBuilder<ReelsExploreCubit, ReelsExploreState>(
                        builder: (context, state) {
                          if (state.reels.isNotEmpty) {
                            return ReelsPageView(
                                vdoController: widget.vdoController,
                                onCommentClick: widget.onCommentClick,
                                controller: _pageController,
                                reels: state.reels,
                                onChaged: (index) {
                                  currentPage = index;
                                });
                          }

                          return loadingWidget();
                        },
                      ),
                    )
                  : BlocBuilder<ReelsCubit, ReelsState>(
                      builder: (context, state) {
                        if (state is ReelsFailure) {
                          return const AppErrorGif();
                        }
                        if (state is ReelsSuccess) {
                          return ReelsPageView(
                              onPause: widget.onPause,
                              isItFromBottomBar: widget.isItFromBottomBar,
                              vdoController: widget.vdoController,
                              onCommentClick: widget.onCommentClick,
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
      required this.onChaged,
      this.isItFromBottomBar = false,
      this.onCommentClick,
      this.vdoController,
      this.onPause});
  final PageController controller;
  final bool isItFromBottomBar;
  final void Function(void Function())? onPause;

  final List<PostEntity> reels;
  final void Function(int) onChaged;
  final void Function(PostEntity)? onCommentClick;
  final VideoPlayerController? vdoController;

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

class VideoPlayerWidget extends StatefulWidget {
  final PostEntity? reel;
  final String? vdo;
  final VoidCallback? onTap;
  final bool playAndLoop;
  final void Function(PostEntity)? onCommentClick;
  final VideoPlayerController? vdoController;
  final bool isItFromBottomBar;
  final bool onlyVdo;
  final void Function(void Function())? onPause;

  const VideoPlayerWidget({
    super.key,
    this.vdo,
    this.isItFromBottomBar = false,
    this.reel,
    this.playAndLoop = true,
    this.onCommentClick,
    this.onlyVdo = false,
    this.onTap,
    this.vdoController,
    this.onPause,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget>
    with WidgetsBindingObserver {
  late VideoPlayerController _controller;
  late String vdoLink;
  @override
  void initState() {
    super.initState();
    vdoLink =
        widget.vdo != null ? widget.vdo! : widget.reel!.postImageUrl.first;
    initializeController();
    if (widget.onPause != null) {
      widget.onPause!(_pauseVideo);
    }
    if (widget.playAndLoop) {
      WidgetsBinding.instance.addObserver(this);
    }
  }

  bool _videoInitialized = false;

  Future<void> initializeController() async {
    try {
      if (kIsWeb) {
        // Handle the video initialization for web

        _controller = VideoPlayerController.networkUrl(Uri.parse(vdoLink))
          ..initialize().then((_) {
            if (mounted) {
              setState(() {
                if (widget.playAndLoop) _controller.setLooping(true);
                if (widget.playAndLoop) _controller.play();
                _videoInitialized = true;
              });
            }
          }).catchError((error) {
            log('Error initializing video controller on web: $error');
          });
        _controller.addListener(() {
          if (_controller.value.isPlaying && !_isPlaying) {
            if (mounted) {
              setState(() {
                _isPlaying = true;
              });
            }
          }
        });
        return;
      }
      var fileInfo = await kCacheManager.getFileFromCache(vdoLink);
      if (fileInfo == null) {
        await kCacheManager.downloadFile(vdoLink);
        fileInfo = await kCacheManager.getFileFromCache(vdoLink);
      }
      if (mounted) {
        _controller = VideoPlayerController.file(fileInfo!.file)
          ..initialize().then((_) {
            if (mounted) {
              setState(() {
                if (widget.playAndLoop) _controller.setLooping(true);
                if (widget.playAndLoop) _controller.play();
                _videoInitialized = true;
              });
            }
          }).catchError((error) {
            log('Error initializing video controller: $error');
          });
        _controller.addListener(() {
          if (_controller.value.isPlaying && !_isPlaying) {
            if (mounted) {
              setState(() {
                _isPlaying = true;
              });
            }
          }
        });
      }
    } on SocketException catch (e) {
      // Handle network errors specifically
      log('Network error: $e');
      // Show an error message to the user or handle it as needed
    } on Exception catch (e) {
      // Handle other types of exceptions
      log('Error handling video file: $e');
      // Show an error message to the user or handle it as needed
    }
  }

  bool _isPlaying = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (!_videoInitialized) return;
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

  void _pauseVideo() {
    if (_videoInitialized && _controller.value.isPlaying) {
      _controller.pause();
    }
  }

  @override
  void dispose() {
    log('this called to dispose');
    WidgetsBinding.instance.removeObserver(this);
    if (_videoInitialized) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final me = context.read<AppUserBloc>().appUser;
    log('is it ini ${widget.vdoController}');
    return widget.isItFromBottomBar
        ? BlocConsumer<BottomBarCubit, BottomBarState>(
            listener: (context, state) {
              if (state.index != 2 && _videoInitialized) {
                _controller.pause();
              } else if (_videoInitialized) {
                _controller.play();
              }
            },
            builder: (context, state) {
              return _getVdoBody(me);
            },
          )
        : _getVdoBody(me);
  }

  Widget _getVdoBody(AppUser me) {
    return SafeArea(
      top: false,
      left: false,
      right: false,
      child: Stack(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (widget.onTap != null) {
                return widget.onTap!();
              }
              if (mounted && _videoInitialized) {
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
              alignment: Alignment.center, // Aligns the play icon to the center
              children: [
                !_videoInitialized
                    ? const Center(
                        child: CircularLoadingGrey(),
                      )
                    : widget.vdo != null
                        ? AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller))
                        : VideoPlayer(_controller),
                if (!_isPlaying)
                  const Icon(
                    Icons.play_arrow,
                    size: 50.0,
                    color: Colors.white,
                  ),
                if (_videoInitialized)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: VideoProgressIndicator(
                      _controller,
                      allowScrubbing: true,
                      colors: VideoProgressColors(
                        playedColor: AppDarkColor().buttonBackground,
                        bufferedColor: Colors.grey,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                if (!widget.onlyVdo && widget.reel != null)
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
                                size: 22, profile: widget.reel!.userProfileUrl),
                            AppSizedBox.sizedBox10W,
                            Expanded(
                              child: CustomText(
                                maxLines: 1,
                                text: addAtSymbol(widget.reel!.username),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(
                                        fontSize:
                                            isThatTabOrDeskTop ? 15 : null),
                              ),
                            ),
                            AppSizedBox.sizedBox10W,
                            if (widget.reel!.creatorUid != me.id)
                              Expanded(
                                child: FollowUnfollowHelper(
                                    wantWhiteBorder: true,
                                    color: Colors.transparent,
                                    noRad: true,
                                    user: PartialUser(
                                        id: widget.reel!.creatorUid)),
                              )
                          ],
                        ),
                        AppSizedBox.sizedBox10H,
                        Column(
                          children: [
                            ExpandableText(
                                text: widget.reel!.description ?? '',
                                trimLines: 2)
                          ],
                        )
                      ],
                    ),
                  ),
                if (!widget.onlyVdo && widget.reel != null)
                  Positioned(
                    right: 10,
                    bottom: 200.h,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Like Button
                        PostLikeButton(
                          me: me,
                          post: widget.reel!,
                          isReel: true,
                        ),
                        AppSizedBox.sizedBox20H,
                        PostCommentButton(
                          onCommentClick: widget.onCommentClick,
                          post: widget.reel!,
                          isReel: true,
                        ),
                        // Share Button
                      ],
                    ),
                  ),
                if (_videoInitialized && widget.vdo != null)
                  Positioned(
                      left: 10,
                      bottom: 10,
                      child: Row(
                        children: [
                          const CustomSvgIcon(
                            height: 15,
                            assetPath: AppAssetsConst.video,
                            color: Colors.white,
                          ),
                          AppSizedBox.sizedBox5W,
                          Text(
                              style:
                                  AppTextTheme.getResponsiveTextTheme(context)
                                      .labelMedium,
                              _controller.value.duration
                                  .videoFormatedDuration()),
                        ],
                      ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
