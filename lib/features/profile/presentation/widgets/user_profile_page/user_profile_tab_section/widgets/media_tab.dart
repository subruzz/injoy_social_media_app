import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/widgets/common/empty_display.dart';

import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_data/get_user_posts_bloc/get_user_posts_bloc.dart';
import 'package:social_media_app/features/profile/presentation/widgets/no_personal_post.dart';
import 'package:social_media_app/features/profile/presentation/widgets/others_profile/other_user_no_post_msg.dart';
import 'package:social_media_app/features/profile/presentation/widgets/user_profile_page/user_profile_tab_section/widgets/media_grid.dart';
import '../../../../../../../core/widgets/common/add_at_symbol.dart';
import '../../../../bloc/other_user/get_other_user_posts/get_other_user_posts_cubit.dart';

class MypostsTab extends StatelessWidget {
  const MypostsTab({
    super.key,
    required this.appUser,
  });
  final AppUser appUser;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserPostsBloc, GetUserPostsState>(
      builder: (context, state) {
        if (state is GetUserPostsLoading) {
          return const Center(
            child: CircularLoadingGrey(),
          );
        } else if (state is GetUserPostsError) {
          return Text(state.errorMsg);
        } else if (state is GetUserPostsSuccess) {
          if (state.userPosts.isEmpty) {
            return const NoPersonalPostWidget();
          }
          return MediaGrid(
            medias: state.userPosts,
            isEdit: true,
            isMe: true,
          );
        }
        return const EmptyDisplay();
      },
    );
  }
}

class OtherUserPosts extends StatelessWidget {
  const OtherUserPosts({super.key, this.userName});
  final String? userName;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetOtherUserPostsCubit, GetOtherUserPostsState>(
      builder: (context, state) {
        if (state is GetOtherUserPostsError) {
          return NoPostsMessage(userName: addAtSymbol(userName));
        }
        if (state is GetOtherUserPostsSuccess) {
          if (state.userPosts.isEmpty) {
            return NoPostsMessage(userName: addAtSymbol(userName));
          }
          return MediaGrid(medias: state.userPosts);
        }
        return const Center(
          child: CircularLoadingGrey(),
        );
      },
    );
  }
}
