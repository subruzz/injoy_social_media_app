import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/widgets/common/cached_image.dart';
import 'package:social_media_app/core/widgets/common/mulitple_post_indicator.dart';
import 'package:social_media_app/features/explore/presentation/widgets/all_post_view.dart';
import 'package:social_media_app/features/reels/presentation/pages/video_page.dart';

import '../../../../../../../core/utils/routes/tranistions/hero_dialog.dart';
import '../../../../../../bottom_nav/presentation/web/popup_container_web.dart';

class PostStaggeredView extends StatelessWidget {
  const PostStaggeredView(
      {super.key, this.showTheList = false, required this.allPosts, this.fit});
  final List<PostEntity> allPosts;
  final bool showTheList;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: allPosts.length,
      itemBuilder: (context, index) {
        final double tileHeight = allPosts[index].isThatvdo ? 1.5 : 1;
        final double aspectRatio = 1 / tileHeight;

        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: GestureDetector(
            onTap: () {
              if (isThatTabOrDeskTop) {
                Navigator.of(context).push(HeroDialogRoute(
                  builder: (context) => PopupContainerWeb(
                    isShorts: allPosts[index].isThatvdo,
                    post: allPosts[index],
                  ),
                ));
                return;
              }
              if (allPosts[index].isThatvdo) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => VideoReelPage(
                      short: !showTheList ? allPosts[index] : null,
                      reels: showTheList ? allPosts : null),
                ));
                return;
              }
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return AllPostView(
                      initialIndex: index,
                      post: !showTheList ? allPosts[index] : null,
                      posts: allPosts);
                },
              ));
            },
            child: MulitplePostOrShortsIndicator(
              isThatShorts: allPosts[index].isThatvdo,
              showIndicator: allPosts[index].postImageUrl.length > 1,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: AspectRatio(
                    aspectRatio: aspectRatio,
                    child: CachedImage(
                        fit: fit,
                        img: allPosts[index].isThatvdo
                            ? allPosts[index].extra!
                            : allPosts[index].postImageUrl.first)),
              ),
            ),
          ),
        );
      },
    );
  }
}
