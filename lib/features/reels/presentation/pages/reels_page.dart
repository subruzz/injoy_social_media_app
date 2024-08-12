import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media_app/animation.dart';
import 'package:social_media_app/core/add_at_symbol.dart';
import 'package:social_media_app/core/app_error_gif.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/widgets/expandable_text.dart';
import 'package:social_media_app/core/widgets/follow_unfollow_helper.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/core/widgets/user_profile.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/common/each_post/post_action_section/widgets/post_comment_button.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/common/each_post/post_action_section/widgets/post_like_button.dart';
import 'package:social_media_app/features/reels/presentation/bloc/reels/reels_cubit.dart';
import 'package:video_player/video_player.dart';

class ReelsPage extends StatefulWidget {
  const ReelsPage({super.key, this.initialIndex = 0, this.availableReels});
  final int initialIndex;
  final List<PostEntity>? availableReels;
  @override
  State<ReelsPage> createState() => _ReelsPageState();
}

class _ReelsPageState extends State<ReelsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: widget.availableReels != null
            ? ReelsPageView(
                reels: widget.availableReels!,
                initialIndex: widget.initialIndex)
            : BlocBuilder<ReelsCubit, ReelsState>(
                builder: (context, state) {
                  if (state is ReelsFailure) {
                    return const AppErrorGif();
                  }
                  if (state is ReelsSuccess) {
                    return ReelsPageView(
                        reels: state.reels, initialIndex: widget.initialIndex);
                  }
                  return loadingWidget();
                },
              ),
      ),
    );
  }
}

class ReelsPageView extends StatelessWidget {
  const ReelsPageView(
      {super.key, required this.reels, required this.initialIndex});
  final List<PostEntity> reels;
  final int initialIndex;
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: PageController(initialPage: initialIndex),
      scrollDirection: Axis.vertical,
      itemCount: reels.length,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            SizedBox(
                height: double.infinity, child: ReelsItem(reel: reels[index])),
          ],
        );
      },
    );
  }
}

class ReelsItem extends StatefulWidget {
  const ReelsItem({super.key, required this.reel});
  final PostEntity reel;

  @override
  State<ReelsItem> createState() => _ReelsItemState();
}

class _ReelsItemState extends State<ReelsItem> {
  late VideoPlayerController _videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;
  final ValueNotifier<Widget> videoStatusAnimation =
      ValueNotifier(const SizedBox());

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.reel.postImageUrl.first))
      ..initialize().then((_) {
        if (mounted) {
          _videoPlayerController.setLooping(true);
          _videoPlayerController.setVolume(1);
          _videoPlayerController.play();
        }
      });
    _initializeVideoPlayerFuture = _videoPlayerController.initialize();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final me = context.read<AppUserBloc>().appUser;
    return Stack(
      children: [
        video(),
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
    );
  }

  Widget video() {
    return Builder(builder: (context) {
      return GestureDetector(
          child: FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return AnimatedBuilder(
                  animation: _videoPlayerController,
                  builder: (context, child) =>
                      VideoPlayer(_videoPlayerController),
                );
              } else {
                return const CircularLoadingGrey();
              }
            },
          ),
          onTap: () {
            if (!_videoPlayerController.value.isInitialized) {
              return;
            }
            if (_videoPlayerController.value.volume == 0) {
              videoStatusAnimation.value =
                  FadeAnimation(child: volumeContainer(Icons.volume_up));
              _videoPlayerController.setVolume(1);
            } else {
              videoStatusAnimation.value =
                  FadeAnimation(child: volumeContainer(Icons.volume_off));
              _videoPlayerController.setVolume(0);
            }
          },
          onLongPressStart: (LongPressStartDetails event) {
            if (!_videoPlayerController.value.isInitialized) {
              return;
            }
            _videoPlayerController.pause();
          },
          onLongPressEnd: (LongPressEndDetails event) {
            if (!_videoPlayerController.value.isInitialized) {
              return;
            }
            _videoPlayerController.play();
          });
    });
  }

  Container volumeContainer(IconData icon) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40), color: Colors.black87),
        padding: const EdgeInsetsDirectional.all(25),
        child: popIcon(icon));
  }

  Icon popIcon(IconData icon, {bool isThatLoveIcon = false}) {
    return Icon(
      icon,
      size: isThatLoveIcon ? 100 : 23.0,
      color: Colors.white,
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
