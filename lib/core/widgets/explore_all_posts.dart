import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/widgets/common/app_error_gif.dart';
import 'package:social_media_app/core/widgets/loading/refresh_indicator.dart';
import 'package:social_media_app/core/widgets/shimmers/explore_post_shimmer.dart';
import 'package:social_media_app/features/explore/presentation/blocs/explore_user/explore_user_cubit.dart';
import 'package:social_media_app/features/explore/presentation/widgets/sections/recommened_posts_tab/widgets/post_staggered_view.dart';

import '../common/shared_providers/blocs/app_user/app_user_bloc.dart';

class ExploreAllPosts extends StatelessWidget {
  const ExploreAllPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Theme(
        data: Theme.of(context).copyWith(
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.blue),
        ),
        child: RefreshIndicatorWrapper(
          onRefresh: () async {
            context
                .read<ExploreAllPostsCubit>()
                .getAllposts(myId: context.read<AppUserBloc>().appUser.id);
          },
          child: BlocBuilder<ExploreAllPostsCubit, ExploreAllPostsState>(
            builder: (context, state) {
              if (state is ExplorePostsError) {
                return const AppErrorGif();
              }
              if (state is ExploreAllPostsLoaded) {
                return PostStaggeredView(allPosts: state.allPosts);
              }
              return const Center(
                child: PostStaggeredViewShimmer(),
              );
            },
          ),
        ),
      ),
    );
  }
}
