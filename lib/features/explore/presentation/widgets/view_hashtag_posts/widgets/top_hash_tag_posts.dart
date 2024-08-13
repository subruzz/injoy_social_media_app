import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/explore/presentation/blocs/get_hashtag_posts/get_hash_tag_posts_cubit.dart';
import 'package:social_media_app/features/explore/presentation/widgets/common_widget/explore_search_loading.dart';
import 'package:social_media_app/features/explore/presentation/widgets/common_widget/search_empty_error_text.dart';
import 'package:social_media_app/features/explore/presentation/widgets/sections/recommened_posts_tab/widgets/post_staggered_view.dart';

class TopHashTagPosts extends StatelessWidget {
  const TopHashTagPosts({super.key, required this.hashtagName});
  final String hashtagName;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetHashTagPostsCubit, GetHashTagPostsState>(
      builder: (context, state) {
        if (state is GetHashTagTopPostSucess) {
          if (state.hashTagTopPosts.isEmpty) {
            return Center(
              child: ExploreFieldMessages(
                query: hashtagName,
              ),
            );
          }
          return PostStaggeredView(allPosts: state.hashTagTopPosts);
        }
        if (state is GetHashTagTopPostFailure) {
          log(state.erroMsg);
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
