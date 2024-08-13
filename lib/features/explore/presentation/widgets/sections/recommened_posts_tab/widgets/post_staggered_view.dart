import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/widgets/common/mulitple_post_indicator.dart';
import 'package:social_media_app/core/utils/routes/tranistions/app_routes_const.dart';
import 'package:social_media_app/features/explore/presentation/pages/all_post_view.dart';

class PostStaggeredView extends StatelessWidget {
  const PostStaggeredView({super.key, required this.allPosts});
  final List<PostEntity> allPosts;

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: allPosts.length,
      itemBuilder: (context, index) {
        // Determine the tile height ratio for more visual interest
        final double tileHeight = (index % 5 == 0) ? 1.4 : 1;
        final double aspectRatio = 1 / tileHeight;

        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return AllPostView(initialIndex: index, posts: allPosts);
                },
              ));
            },
            child: MulitplePostIndicator(
              showIndicator: allPosts[index].postImageUrl.length > 1,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: AspectRatio(
                  aspectRatio: aspectRatio, // Adjust aspect ratio for variety
                  child: CachedNetworkImage(
                    imageUrl: allPosts[index].postImageUrl.first,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
