import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/app_error_gif.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/features/explore/presentation/blocs/explore_user/explore_user_cubit.dart';
import 'package:social_media_app/features/explore/presentation/widgets/sections/recommened_posts_tab/widgets/post_staggered_view.dart';
import 'package:social_media_app/features/profile/presentation/widgets/profile_page/media_grid.dart';
import 'package:social_media_app/init_dependecies.dart';


class ExploreAllPosts extends StatelessWidget {
  const ExploreAllPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocProvider(
        create: (context) => serviceLocator<ExploreAllPostsCubit>()
          ..getAllposts(myId: context.read<AppUserBloc>().appUser.id),
        child: BlocBuilder<ExploreAllPostsCubit, ExploreAllPostsState>(
          builder: (context, state) {
            if (state is ExplorePostsError) {
              return const AppErrorGif();
            }
            if (state is ExploreAllPostsLoaded) {
              return PostStaggeredView(allPosts: state.allPosts);
            }
            return const Center(
              child: CircularLoadingGrey(),
            );
          },
        ),
      ),
    );
  }
}
