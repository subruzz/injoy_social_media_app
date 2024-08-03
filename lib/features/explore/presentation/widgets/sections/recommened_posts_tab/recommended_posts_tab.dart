import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/explore/presentation/blocs/get_recommended_post/get_recommended_post_cubit.dart';
import 'package:social_media_app/features/explore/presentation/widgets/common_widget/explore_search_loading.dart';
import 'package:social_media_app/features/explore/presentation/widgets/common_widget/search_empty_error_text.dart';
import 'package:social_media_app/features/explore/presentation/widgets/sections/recommened_posts_tab/widgets/post_staggered_view.dart';

class RecommendedPostsTab extends StatelessWidget {
  const RecommendedPostsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetRecommendedPostCubit, GetRecommendedPostState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetRecommendedPostSuccess) {
          if (state.recommendedPosts.isEmpty) {
            return ExploreFieldMessages(query: state.query);
          }
          return PostStaggeredView(allPosts: state.recommendedPosts);
        }
        if (state is GetRecommendedPostFailure) {
          return const ExploreFieldMessages(
            isError: true,
          );
        }
        return const ExploreSearchLoading();
      },
    );
  }
}
