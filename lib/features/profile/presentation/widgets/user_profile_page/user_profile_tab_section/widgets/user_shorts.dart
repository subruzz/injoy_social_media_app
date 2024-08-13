import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/widgets/common/app_error_gif.dart';
import 'package:social_media_app/core/widgets/app_related/empty_display.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/features/profile/presentation/bloc/other_user/get_other_user_reels/get_other_user_shorts_cubit.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_data/get_my_reels/get_my_reels_cubit.dart';
import 'package:social_media_app/features/profile/presentation/widgets/user_profile_page/user_profile_tab_section/widgets/media_grid.dart';

class MyShortsTab extends StatelessWidget {
  const MyShortsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetMyReelsCubit, GetMyReelsState>(
      builder: (context, state) {
        if (state is GetUserShortsLoading) {
          return const Center(
            child: CircularLoadingGrey(),
          );
        } else if (state is GetUserShortsError) {
          return const AppErrorGif();
        } else if (state is GetUserShortsSuccess) {
          if (state.myShorts.isEmpty) {
            return const Center(
              child: Text('No Shorts Found'),
            );
          }
          return MediaGrid(
            medias: state.myShorts,
            isShorts: true,
          );
        }

        return const EmptyDisplay();
      },
    );
  }
}

class OtherUserShortsTab extends StatelessWidget {
  const OtherUserShortsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetOtherUserShortsCubit, GetOtherUserShortsState>(
      builder: (context, state) {
        if (state is GetOtherUserShortsLoading) {
          return const Center(
            child: CircularLoadingGrey(),
          );
        } else if (state is GetOtherUserShortsError) {
          return const AppErrorGif();
        } else if (state is GetOtherUserShortsSuccess) {
          if (state.myShorts.isEmpty) {
            return const Center(
              child: Text('No Shorts Found'),
            );
          }
          return MediaGrid(
            medias: state.myShorts,
            isShorts: true,
          );
        }

        return const EmptyDisplay();
      },
    );
  }
}
