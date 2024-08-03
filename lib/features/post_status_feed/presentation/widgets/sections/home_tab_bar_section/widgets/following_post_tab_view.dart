import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/app_error_gif.dart';
import 'package:social_media_app/features/post_status_feed/presentation/pages/welcome_card.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/common/each_post/each_post.dart';
import 'package:social_media_app/core/widgets/shimmer.dart';
import 'package:social_media_app/features/post_status_feed/presentation/bloc/following_post_feed/following_post_feed_bloc.dart';

class FollowingPostTabView extends StatefulWidget {
  const FollowingPostTabView({super.key});

  @override
  State<FollowingPostTabView> createState() => _FollowingPostTabViewState();
}

class _FollowingPostTabViewState extends State<FollowingPostTabView> {
  // late ScrollController _scrollController;

  // @override
  // void initState() {
  //   super.initState();
  //   _loadInitialPosts();
  //   _scrollController = ScrollController()..addListener(_onScroll);
  // }

  // void _loadInitialPosts() {
  //   final user = context.read<AppUserBloc>().appUser;
  //   BlocProvider.of<FollowingPostFeedBloc>(context).add(
  //     FollowingPostFeedGetEvent(
  //       uId: user.id,
  //       isLoadMore: false, // Not a load more operation initially
  //       lastDoc: null, // No last document snapshot initially
  //       following: user.following,
  //     ),
  //   );
  // }

  // int c = 0;
  // @override
  // void dispose() {
  //   _scrollController.removeListener(_onScroll);
  //   _scrollController.dispose();
  //   super.dispose();
  // }

  // void _onScroll() {
  //   if (_scrollController.position.pixels ==
  //       _scrollController.position.maxScrollExtent) {
  //     log('this called this much ${c++} ');
  //     final bloc = BlocProvider.of<FollowingPostFeedBloc>(context);
  //     final state = bloc.state;
  //     final user = context.read<AppUserBloc>().appUser;
  //     if (state is FollowingPostFeedSuccess && state.hasMore) {
  //       bloc.add(FollowingPostFeedGetEvent(
  //         uId: user.id, // replace with actual userId
  //         following: user.following, // replace with actual following list
  //         isLoadMore: true,
  //         lastDoc: state.lastDoc,
  //       ));
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FollowingPostFeedBloc, FollowingPostFeedState>(
      builder: (context, state) {
        if (state is FollowingPostFeedError) {
          return const SliverToBoxAdapter(child: AppErrorGif());
        }
        if (state is AllUsersLoaded) {
          return SliverToBoxAdapter(
            child: SizedBox(
              height: .7.sh,
              child: WelcomeCard(
                allUsers: state.allUsers,
              ),
            ),
          );
        }
        if (state is FollowingPostFeedSuccess) {
          if (state.followingPosts.isEmpty) {}
          return SliverList.builder(
            // controller: _scrollController,
            itemCount: state.followingPosts.length,
            //  state.hasMore
            //     ? state.followingPosts.length + 1
            //     : state.followingPosts.length,
            itemBuilder: (context, index) {
              // if (index >= state.followingPosts.length) {
              //   return Center(child: CircularProgressIndicator());
              // }
              final currentPost = state.followingPosts[index];
              return EachPost(currentPost: currentPost);
            },
          );
        }

        return const ShimmerEachPost();
      },
    );
  }
}
