import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/explore/presentation/blocs/get_recent_hashtag_posts/get_recent_hashtag_posts_cubit.dart';
import 'package:social_media_app/features/explore/presentation/widgets/explore_main_page/common_widgets/explore_search_loading.dart';
import 'package:social_media_app/features/explore/presentation/widgets/explore_main_page/common_widgets/search_empty_error_text.dart';
import 'package:social_media_app/features/explore/presentation/widgets/explore_main_page/sections/recommened_posts_tab/widgets/post_staggered_view.dart';

class RecentHashtagPosts extends StatelessWidget {
  const RecentHashtagPosts({super.key, required this.hashtagName});
  final String hashtagName;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetRecentHashtagPostsCubit, GetRecentHashtagPostsState>(
      builder: (context, state) {
        if (state is GetHashTagRecentPostSucess) {
          if (state.hashTagRecentPosts.isEmpty) {
            return Center(
              child: ExploreFieldMessages(
                query: hashtagName,
              ),
            );
          }
          return PostStaggeredView(allPosts: state.hashTagRecentPosts);
        }
        if (state is GetHashTagRecentPostFailure) {
          return const Center(
            child: ExploreFieldMessages(
              isError: true,
            ),
          );
        }
        return const ExploreSearchLoading();
      },
    );
  }
}
