import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/mulitple_post_indicator.dart';

class PostStaggeredView extends StatelessWidget {
  const PostStaggeredView({super.key, required this.allPosts});
  final List<PostEntity> allPosts;
  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      itemCount: allPosts.length,
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(3.0),
        child: MulitplePostIndicator(
          showIndicator: allPosts[index].postImageUrl.length > 1,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: CachedNetworkImage(
              imageUrl: allPosts[index].postImageUrl.first,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}
