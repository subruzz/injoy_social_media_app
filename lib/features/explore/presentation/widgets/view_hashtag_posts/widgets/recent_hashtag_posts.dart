import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/explore/presentation/blocs/get_shorts_of_tag/get_shorts_hashtag_cubit.dart';
import 'package:social_media_app/features/explore/presentation/widgets/common_widget/explore_search_loading.dart';
import 'package:social_media_app/features/explore/presentation/widgets/common_widget/search_empty_error_text.dart';
import 'package:social_media_app/features/explore/presentation/widgets/sections/recommened_posts_tab/widgets/post_staggered_view.dart';

class ShortsOfLocationORTag extends StatelessWidget {
  const ShortsOfLocationORTag({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetShortsHashtagCubit, GetShortsHashtagState>(
      builder: (context, state) {
        if (state is GetHashTagRecentPostSucess) {
          if (state.hashTagRecentPosts.isEmpty) {
            return Center(
              child: ExploreFieldMessages(
                query: name,
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
