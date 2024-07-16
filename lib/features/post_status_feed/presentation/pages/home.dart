import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/const/app_config/app_border_radius.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/shared_providers/blocs/initial_setup/initial_setup_cubit.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/core/widgets/shimmer.dart';
import 'package:social_media_app/features/post_status_feed/presentation/bloc/for_you_posts/for_you_post_bloc.dart';
import 'package:social_media_app/features/post_status_feed/presentation/bloc/following_post_feed/following_post_feed_bloc.dart';
import 'package:social_media_app/core/widgets/post/each_post.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/floating_button.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/status/user_status.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const FloatingButton(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'INJOY',
          style: Theme.of(context)
              .textTheme
              .displayMedium
              ?.copyWith(letterSpacing: 5),
        ),
        actions: [
          if (context.read<AppUserBloc>().appUser.profilePic != null)
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: CircleAvatar(
                  backgroundColor: AppDarkColor().background,
                  radius: 23,
                  backgroundImage: CachedNetworkImageProvider(
                      context.read<AppUserBloc>().appUser.profilePic!)),
            )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context
              .read<InitialSetupCubit>()
              .startInitialSetup(uId: context.read<AppUserBloc>().appUser.id);
        },
        child: SafeArea(
          child: Center(
            child: DefaultTabController(
              length: 2,
              child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverList(
                          delegate: SliverChildListDelegate(
                              [AppSizedBox.sizedBox5H, const UserStatus()]))
                    ];
                  },
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppSizedBox.sizedBox5H,
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, bottom: 10),
                        child: Container(
                          alignment: Alignment.center,
                          width: 200.w,
                          height: 30.h,
                          child: TabBar(
                            dividerHeight: 0,
                            indicator: BoxDecoration(
                                color: Colors.grey[700],
                                borderRadius: AppBorderRadius.extraLarge),
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.white,
                            tabs: const [
                              Tab(
                                text: 'Following',
                              ),
                              Tab(
                                text: 'For you',
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            BlocBuilder<FollowingPostFeedBloc,
                                FollowingPostFeedState>(
                              builder: (context, state) {
                                if (state is FollowingPostFeedError) {
                                  return CircularLoading();
                                }
                                if (state is FollowingPostFeedSuccess) {
                                  log('success satetaefo posts ${state.followingPosts.length}');
                                  return ListView.builder(
                                    itemCount: state.followingPosts.length,
                                    itemBuilder: (context, index) {
                                      final currentPost =
                                          state.followingPosts[index];
                                      return EachPost(currentPost: currentPost);
                                    },
                                  );
                                }

                                return ListView.builder(
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return ShimmerEachPost();
                                  },
                                );
                              },
                            ),
                            BlocBuilder<ForYouPostBloc, ForYouPostState>(
                              builder: (context, state) {
                                if (state is ForYouPostFeedError) {
                                  return CircularLoading();
                                }
                                if (state is ForYouPostFeedSuccess) {
                                  log('success satetaefo posts ${state.forYouPosts.length}');
                                  return ListView.builder(
                                    itemCount: state.forYouPosts.length,
                                    itemBuilder: (context, index) {
                                      final currentPost =
                                          state.forYouPosts[index];
                                      return EachPost(currentPost: currentPost);
                                    },
                                  );
                                }

                                return ListView.builder(
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return ShimmerEachPost();
                                  },
                                );
                              },
                            ),
                            // UsersPostsTab(),
                            // UserLikedPostsTab(),
                          ],
                        ),
                      )
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
