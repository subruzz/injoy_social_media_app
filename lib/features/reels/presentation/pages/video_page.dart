import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/utils/di/init_dependecies.dart';
import 'package:social_media_app/core/widgets/app_related/empty_display.dart';
import 'package:social_media_app/features/explore/presentation/blocs/reels_explore/reels_explore_cubit.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_data/get_my_reels/get_my_reels_cubit.dart';
import 'package:social_media_app/features/reels/domain/usecases/get_reels.dart';
import 'package:social_media_app/features/reels/presentation/widgets/video_loading_shimmer.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/widgets/common/app_error_gif.dart';
import '../../../../core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import '../../../../core/widgets/common/video_playing_widget.dart';
import '../bloc/reels/reels_cubit.dart';
import '../widgets/video_page_view.dart';

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
      this.isMyShorts = false,
      this.onPause});
  final List<PostEntity>? reels;
  final void Function(PostEntity)? onCommentClick;
  final VideoPlayerController? vdoController;
  final bool isItFromBottomBar;
  final bool showOne;
  final int index;
  final PostEntity? short;
  final bool isMyShorts;
  final void Function(void Function())? onPause;

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
      body: widget.isMyShorts
          ? BlocConsumer<GetMyReelsCubit, GetMyReelsState>(
              listener: (context, state) {
                if (state is GetUserShortsSuccess && state.myShorts.isEmpty) {
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                if (state is GetUserShortsSuccess) {
                  return VideoPageView(
                      onCommentClick: widget.onCommentClick,
                      controller: _pageController,
                      reels: state.myShorts,
                      onChaged: (index) {
                        currentPage = index;
                      });
                }
                return const EmptyDisplay();
              },
            )
          : widget.short != null && widget.showOne
              ? VideoPlayerWidget(
                  reel: widget.short!,
                  onCommentClick: widget.onCommentClick,
                )
              : widget.reels != null
                  ? VideoPageView(
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
                          child:
                              BlocBuilder<ReelsExploreCubit, ReelsExploreState>(
                            builder: (context, state) {
                              if (state.reels.isNotEmpty) {
                                return VideoPageView(
                                    vdoController: widget.vdoController,
                                    onCommentClick: widget.onCommentClick,
                                    controller: _pageController,
                                    reels: state.reels,
                                    onChaged: (index) {
                                      currentPage = index;
                                    });
                              }

                              return const VideoLoadingShimmer();
                            },
                          ),
                        )
                      : BlocBuilder<ReelsCubit, ReelsState>(
                          builder: (context, state) {
                            if (state is ReelsFailure) {
                              return const AppErrorGif();
                            }
                            if (state is ReelsSuccess) {
                              return VideoPageView(
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
                            return const VideoLoadingShimmer();
                          },
                        ),
    );
  }
}
