import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/features/profile/presentation/bloc/get_user_posts_bloc/get_user_posts_bloc.dart';
import 'package:social_media_app/features/profile/presentation/widgets/no_post_placeholder.dart';
import 'package:social_media_app/features/profile/presentation/widgets/profile_page/media_grid.dart';

class UsersPostsTab extends StatelessWidget {
  const UsersPostsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserPostsBloc, GetUserPostsState>(
      builder: (context, state) {
        if (state is GetUserPostsLoading) {
          return const Expanded(
              child: Center(
            child: CircularLoadingGrey(),
          ));
        } else if (state is GetUserPostsError) {
          return Text(state.errorMsg);
        } else if (state is GetUserPostsSuccess) {
          if (state.userAllPostImages.isEmpty) {
            return const NoPostsPlaceholder();
          }
          return MediaGrid(medias: state.userPosts);
        }
        return const SizedBox.shrink();
      },
    );
  }
}

