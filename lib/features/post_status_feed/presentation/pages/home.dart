import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/app_sizedbox.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/features/post_status_feed/presentation/bloc/following_post_feed/following_post_feed_bloc.dart';
import 'package:social_media_app/core/widgets/post/each_post.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/floating_button.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/post/post_selection_button.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/user_status.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: const FloatingButton(),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              title: Text(
                'INJOY',
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(letterSpacing: 5),
              ),
              actions: [
                if (context.read<AppUserBloc>().appUser!.profilePic != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: CircleAvatar(
                        backgroundColor: AppDarkColor().background,
                        radius: 23,
                        backgroundImage: CachedNetworkImageProvider(
                            context.read<AppUserBloc>().appUser!.profilePic!)),
                  )
              ],
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  AppSizedBox.sizedBox10H,
                  const UserStatus(),
                  const PostSelectionButton(),
                  AppSizedBox.sizedBox10H,
                ],
              ),
            ),
            BlocBuilder<FollowingPostFeedBloc, FollowingPostFeedState>(
              builder: (context, state) {
                if (state is FollowingPostFeedSuccess) {
                  return SliverList.builder(
                    itemCount: state.followingPosts.length,
                    itemBuilder: (context, index) {
                      final currentPost = state.followingPosts[index];
                      print(currentPost.likes.length);
                      return EachPost(currentPost: currentPost);
                    },
                  );
                }
                return const SliverToBoxAdapter(
                  child: SizedBox(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
