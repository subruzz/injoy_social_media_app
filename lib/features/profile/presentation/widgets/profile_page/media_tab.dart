import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/features/profile/presentation/bloc/get_user_posts_bloc/get_user_posts_bloc.dart';

class MediaTab extends StatelessWidget {
  const MediaTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserPostsBloc, GetUserPostsState>(
      builder: (context, state) {
        if (state is GetUserPostsLoading) {
          return const CircularProgressIndicator();
        } else if (state is GetUserPostsError) {
          return Text(state.errorMsg);
        } else if (state is GetUserPostsSuccess) {
          if (state.userAllPostImages.isEmpty) {
            return const Center(
              child: Text('No Media Found,Post something to see here'),
            );
          }
          return MasonryGridView.builder(
              itemCount: state.userAllPostImages.length,
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
              itemBuilder: (context, index) => CachedNetworkImage(
                    imageUrl: state.userAllPostImages[index],
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const CircularLoading(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
