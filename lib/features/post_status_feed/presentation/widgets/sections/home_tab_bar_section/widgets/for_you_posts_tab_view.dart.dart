import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/widgets/common/app_error_gif.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/common/each_post/each_post.dart';
import 'package:social_media_app/core/widgets/common/shimmer.dart';
import 'package:social_media_app/features/post_status_feed/presentation/bloc/for_you_posts/for_you_post_bloc.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/common/no_post_holder.dart';

class ForYouPostsTabView extends StatelessWidget {
  const ForYouPostsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForYouPostBloc, ForYouPostState>(
      builder: (context, state) {
        if (state is ForYouPostFeedError) {
          return const AppErrorGif();
        }
        if (state is ForYouPostFeedSuccess) {
          if (state.forYouPosts.isEmpty) {
            return const NoPostHolder();
          }
          return ListView.builder(
            itemCount: state.forYouPosts.length,
            itemBuilder: (context, index) {
              final currentPost = state.forYouPosts[index];
              return EachPost(currentPost: currentPost);
            },
          );
        }

        return const ShimmerEachPost();
      },
    );
  }
}
