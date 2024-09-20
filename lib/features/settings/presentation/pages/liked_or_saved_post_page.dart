import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/utils/extensions/localization.dart';
import 'package:social_media_app/core/widgets/common/app_custom_appbar.dart';
import 'package:social_media_app/core/widgets/common/app_error_gif.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/core/widgets/no_post_holder.dart';
import 'package:social_media_app/core/widgets/web/web_width_helper.dart';
import 'package:social_media_app/features/profile/presentation/widgets/user_profile_page/user_profile_tab_section/widgets/media_grid.dart';
import 'package:social_media_app/features/settings/presentation/cubit/cubit/liked_or_saved_posts_cubit.dart';

class LikedOrSavedPostPage extends StatelessWidget {
  const LikedOrSavedPostPage({super.key, required this.isLiked});
  final bool isLiked;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppCustomAppbar(
        title: isLiked ? l10n!.liked_posts : l10n!.saved_posts,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          if (context.mounted) {
            final user = context.read<AppUserBloc>().appUser;
            if (isLiked) {
              context.read<LikedOrSavedPostsCubit>().getLikedPosts(user.id);
            } else {
              context
                  .read<LikedOrSavedPostsCubit>()
                  .getSavedPosts(user.savedPosts);
            }
          }
        },
        child: BlocBuilder<LikedOrSavedPostsCubit, LikedOrSavedPostsState>(
          builder: (context, state) {
            if (state is LikedOrSavedPostsFailure) {
              return const AppErrorGif();
            }
            if (state is LikedOrSavedPostsSuccess) {
              log('liked or another post length is ${state.likedOrSavedPosts.length}');
              if (state.likedOrSavedPosts.isEmpty) {
                return NoPostHolder(
                  text:
                      l10n.no_posts_found_dynamic(isLiked ? 'Liked' : 'Saved'),
                );
              }
              return WebWidthHelper(
                width: 700,
                child: MediaGrid(
                  medias: state.likedOrSavedPosts,
                  showOnlyOne: true,
                ),
              );
            }
            return const Center(child: CircularLoadingGrey());
          },
        ),
      ),
    );
  }
}
