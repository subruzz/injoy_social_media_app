import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/widgets/common/app_error_gif.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/features/post_status_feed/presentation/pages/welcome_card.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/common/each_post/each_post.dart';
import 'package:social_media_app/core/widgets/common/shimmer.dart';
import 'package:social_media_app/features/post_status_feed/presentation/bloc/following_post_feed/following_post_feed_bloc.dart';

import '../../../../../../../core/common/shared_providers/blocs/app_user/app_user_bloc.dart';

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
          return SliverList.builder(
            itemCount: state.hasMore
                ? state.followingPosts.length + 1
                : state.followingPosts.length,
            itemBuilder: (context, index) {
              if (index == state.followingPosts.length) {
                return const Center(child: CircularLoadingGrey());
              }
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
