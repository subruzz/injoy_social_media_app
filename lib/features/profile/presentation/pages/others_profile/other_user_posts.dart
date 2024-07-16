import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/add_at_symbol.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/features/profile/presentation/bloc/get_other_user_posts/get_other_user_posts_cubit.dart';
import 'package:social_media_app/features/profile/presentation/widgets/profile_page/media_grid.dart';

class OtherUserPosts extends StatelessWidget {
  const OtherUserPosts({super.key, required this.userName});
  final String userName;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetOtherUserPostsCubit, GetOtherUserPostsState>(
      builder: (context, state) {
        if (state is GetOtherUserPostsSuccess) {
          if (state.userPosts.isEmpty) {
            return NoPostsMessage(userName: addAtSymbol(userName));
          }
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

class NoPostsMessage extends StatelessWidget {
  final String userName;

  const NoPostsMessage({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                style: Theme.of(context).textTheme.labelMedium,
                children: [
                  TextSpan(
                      text: userName,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  TextSpan(
                    text: ' hasn\'t shared \nany posts yet.',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
