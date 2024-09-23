import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/widgets/common/app_error_gif.dart';
import 'package:social_media_app/core/widgets/common/empty_display.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/features/profile/presentation/bloc/other_user/get_other_user_reels/get_other_user_shorts_cubit.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_data/get_my_reels/get_my_reels_cubit.dart';
import 'package:social_media_app/features/profile/presentation/widgets/no_personal_post.dart';
import 'package:social_media_app/features/profile/presentation/widgets/user_profile_page/user_profile_tab_section/widgets/media_grid.dart';

import '../../../../../../../core/common/entities/user_entity.dart';
import '../../../../../../../core/widgets/common/add_at_symbol.dart';
import '../../../others_profile/other_user_no_post_msg.dart';

class MyShortsTab extends StatelessWidget {
  const MyShortsTab({super.key, required this.appUser});
  final AppUser appUser;

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
            return const NoPersonalPostWidget(
              isShorts: true,
            );
          }
          return MediaGrid(
            isMe: true,
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
  const OtherUserShortsTab({super.key, required this.userName});
  final String? userName;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetOtherUserShortsCubit, GetOtherUserShortsState>(
      builder: (context, state) {
        if (state is GetOtherUserShortsLoading) {
          return const Center(
            child: CircularLoadingGrey(),
          );
        } else if (state is GetOtherUserShortsError) {
          return const NoPostsMessage(userName: '');
        } else if (state is GetOtherUserShortsSuccess) {
          if (state.myShorts.isEmpty) {
            return Center(
                child: NoPostsMessage(
              isShorts: true,
              userName: addAtSymbol(userName),
            ));
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
