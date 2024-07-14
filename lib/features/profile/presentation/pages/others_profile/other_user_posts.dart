import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/features/profile/presentation/bloc/get_other_user_posts/get_other_user_posts_cubit.dart';
import 'package:social_media_app/features/profile/presentation/widgets/profile_page/media_grid.dart';

class OtherUserPosts extends StatelessWidget {
  const OtherUserPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetOtherUserPostsCubit, GetOtherUserPostsState>(
      builder: (context, state) {
        if (state is GetOtherUserPostsSuccess) {
          return Expanded(child: MediaGrid(medias: state.userPosts));
        }
        return const Expanded(
            child: Center(
          child: CircularLoadingGrey(),
        ));
      },
    );
  }
}
