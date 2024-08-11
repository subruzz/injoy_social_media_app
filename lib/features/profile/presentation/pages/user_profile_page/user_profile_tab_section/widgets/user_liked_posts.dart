import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/widgets/app_related/empty_display.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/features/profile/presentation/bloc/get_my_reels/get_my_reels_cubit.dart';
import 'package:social_media_app/features/profile/presentation/bloc/get_user_liked_posts/get_user_liked_posts_cubit.dart';
import 'package:social_media_app/features/profile/presentation/widgets/no_post_placeholder.dart';
import 'package:social_media_app/features/profile/presentation/widgets/profile_page/media_grid.dart';
import 'package:social_media_app/init_dependecies.dart';

class UserLikedPostsTab extends StatelessWidget {
  const UserLikedPostsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<GetMyReelsCubit>()
        ..getMyReels(PartialUser(
            id: context.read<AppUserBloc>().appUser.id,
            userName: context.read<AppUserBloc>().appUser.userName,
            fullName: context.read<AppUserBloc>().appUser.fullName,
            profilePic: context.read<AppUserBloc>().appUser.profilePic)),
      child: BlocBuilder<GetMyReelsCubit, GetMyReelsState>(
          builder: (context, state) {
        if (state is GetUserShortsLoading) {
          return const Center(
            child: CircularLoadingGrey(),
          );
        } else if (state is GetUserShortsError) {
          return Text('dfdsf');
        } else if (state is GetUserShortsSuccess) {
          if (state.myShorts.isEmpty) {
            return const Center(
              child: Text('No Liked Posts Found'),
            );
          }
          return MediaGrid(
            medias: state.myShorts,
            isShorts: true,
          );
        }

        return const EmptyDisplay();
      }),
    );
  }
}
