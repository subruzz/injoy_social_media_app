import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media_app/features/profile/presentation/bloc/get_user_posts_bloc/get_user_posts_bloc.dart';
import 'package:social_media_app/features/profile/presentation/widgets/profile_page/media_grid.dart';

class MediaTab extends StatelessWidget {
  const MediaTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserPostsBloc, GetUserPostsState>(
      builder: (context, state) {
        if (state is GetUserPostsLoading) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              color: Colors.white,
              margin:const EdgeInsets.all(8.0),
            ),
          );
          
        } else if (state is GetUserPostsError) {
          return Text(state.errorMsg);
        } else if (state is GetUserPostsSuccess) {
          if (state.userAllPostImages.isEmpty) {
            return const Center(
              child: Text('No Media Found,Post something to see here'),
            );
          }
          return MediaGrid(medias: state.userAllPostImages);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
