import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/widgets/app_related/empty_display.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/features/profile/presentation/bloc/get_user_liked_posts/get_user_liked_posts_cubit.dart';
import 'package:social_media_app/features/profile/presentation/widgets/no_post_placeholder.dart';
import 'package:social_media_app/features/profile/presentation/widgets/profile_page/media_grid.dart';
import 'package:social_media_app/init_dependecies.dart';

class UserLikedPostsTab extends StatelessWidget {
  const UserLikedPostsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<GetUserLikedPostsCubit>()
        ..getMyLikedpost(context.read<AppUserBloc>().appUser.id),
      child: BlocBuilder<GetUserLikedPostsCubit, GetUserLikedPostsState>(
          builder: (context, state) {
        if (state is GetUserLikedPostsLoading) {
          return const Center(
            child: CircularLoadingGrey(),
          );
        } else if (state is GetUserLikedPostsError) {
          return Text(state.errorMsg);
        } else if (state is GetUserLikedPostsSuccess) {
          if (state.userLikePosts.isEmpty) {
            return const Center(
              child: Text('No Liked Posts Found'),
            );
          }
          return MediaGrid(medias: state.userLikePosts);
        }

        return const EmptyDisplay();
      }),
    );
  }
}
