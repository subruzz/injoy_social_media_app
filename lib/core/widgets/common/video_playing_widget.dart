import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/utils/extensions/video_duration.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/theme/widget_themes/text_theme.dart';
import 'package:social_media_app/core/widgets/common/app_back_button.dart';
import 'package:social_media_app/core/widgets/common/app_svg.dart';
import 'package:social_media_app/core/widgets/common/common_text.dart';
import 'package:social_media_app/core/widgets/common/add_at_symbol.dart';
import 'package:social_media_app/core/widgets/each_post/post_content_section/widgets/post_hashtag.dart';
import 'package:social_media_app/core/widgets/each_post/post_top_section/widgets/post_option_button.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/features/profile/presentation/pages/profile_page_wrapper.dart';
import 'package:video_player/video_player.dart';
import '../../../features/bottom_nav/presentation/cubit/bottom_bar_cubit.dart';
import '../../common/entities/post.dart';
import '../../common/entities/user_entity.dart';
import '../../const/app_config/app_sizedbox.dart';
import '../../services/app_cache/cache_manager.dart';
import '../../utils/responsive/constants.dart';
import '../../utils/routes/tranistions/app_routes_const.dart';
import '../each_post/post_action_section/widgets/post_comment_button.dart';
import '../each_post/post_action_section/widgets/post_like_button.dart';
import '../helper/follow_unfollow_helper.dart';
import 'cached_image.dart';
import 'expandable_text.dart';
import 'user_profile.dart';

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
  final PageController? pageController;
  final int? currentIndex;
  final bool isItMine;
  const VideoPlayerWidget({
    super.key,
    this.isItMine = false,
    this.vdo,
    this.isItFromBottomBar = false,
    this.reel,
    this.playAndLoop = true,
    this.onCommentClick,
    this.onlyVdo = false,
    this.onTap,
    this.vdoController,
    this.onPause,
    this.pageController,
    this.currentIndex,
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
          }).catchError((error) {});
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
          }).catchError((error) {});
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
    } on SocketException catch (_) {
    } on Exception catch (_) {}
  }

  bool _isPlaying = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (widget.isItFromBottomBar &&
        context.read<BottomBarCubit>().state.index != 2) return;
    if (!_videoInitialized) {
      return;
    }
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
    WidgetsBinding.instance.removeObserver(this);
    if (_videoInitialized) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final me = context.read<AppUserBloc>().appUser;
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
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (mounted && _videoInitialized) {
          _controller.pause();
        }
      },
      child: SafeArea(
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
                alignment: Alignment.center,
                children: [
                  !_videoInitialized && widget.reel != null
                      ? SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              CachedImage(
                                img: widget.reel!.extra ?? '',
                                fit: BoxFit.fill,
                              ),
                              const Align(
                                alignment: Alignment.center,
                                child: CircularLoadingGrey(),
                              )
                            ],
                          ),
                        )
                      : widget.vdo != null && _videoInitialized
                          ? AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: VideoPlayer(_controller),
                            )
                          : _videoInitialized
                              ? VideoPlayer(_controller)
                              : const Center(
                                  child: CircularProgressIndicator()),
                  if (!_isPlaying && _videoInitialized)
                    const Icon(
                      Icons.play_arrow,
                      size: 50.0,
                      color: Colors.white,
                    ),
                   SafeArea(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back)),
                    ),
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
                      child: GestureDetector(
                        onTap: () {},
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (_videoInitialized &&
                                        _controller.value.isPlaying) {
                                      _controller.pause();
                                    }
                                    if (widget.reel!.creatorUid ==
                                        context
                                            .read<AppUserBloc>()
                                            .appUser
                                            .id) {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) {
                                          return const ProfilePageWrapper();
                                        },
                                      ));
                                      return;
                                    }
                                    Navigator.pushNamed(context,
                                        MyAppRouteConst.otherUserProfile,
                                        arguments: {
                                          'user': PartialUser(
                                              id: widget.reel!.creatorUid,
                                              userName:
                                                  widget.reel!.userFullName,
                                              fullName:
                                                  widget.reel!.userFullName,
                                              profilePic:
                                                  widget.reel!.userProfileUrl)
                                        });
                                  },
                                  child: CircularUserProfile(
                                      size: 22,
                                      profile: widget.reel!.userProfileUrl),
                                ),
                                AppSizedBox.sizedBox10W,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        maxLines: 1,
                                        text:
                                            addAtSymbol(widget.reel!.username),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(
                                                fontSize: isThatTabOrDeskTop
                                                    ? 15
                                                    : null),
                                      ),
                                      if (widget.reel!.location != null)
                                        CustomText(
                                          maxLines: 1,
                                          text: '📍${widget.reel!.location}',
                                          style: AppTextTheme
                                                  .getResponsiveTextTheme(
                                                      context)
                                              .bodyMedium
                                              ?.copyWith(),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                    ],
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
                                if (widget.reel!.description != null)
                                  ExpandableText(
                                      otherW: widget.reel!.hashtags.isEmpty
                                          ? null
                                          : PostHashtag(
                                              hashtags: widget.reel!.hashtags),
                                      text: widget.reel!.description ?? '',
                                      trimLines: 2),
                                if (widget.reel!.description == null)
                                  PostHashtag(hashtags: widget.reel!.hashtags),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  if (!widget.onlyVdo && widget.reel != null)
                    Positioned(
                      right: 10,
                      bottom: 160.h,
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
                          AppSizedBox.sizedBox20H,
                          if (widget.pageController != null && widget.isItMine)
                            PostOptionButton(
                                isMyPost: true,
                                isShorts: true,
                                post: widget.reel!,
                                currentPostIndex: widget.currentIndex ?? 0,
                                pagecontroller: widget.pageController!)
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
                        )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
