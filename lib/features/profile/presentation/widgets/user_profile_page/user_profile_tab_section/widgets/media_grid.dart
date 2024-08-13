import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/features/reels/presentation/pages/video_page.dart';

import '../../../../../../explore/presentation/pages/all_post_view.dart';

class MediaGrid extends StatelessWidget {
  const MediaGrid(
      {super.key,
      required this.medias,
      this.isShorts = false,
      this.isEdit = false});
  final List<PostEntity> medias;
  final bool isEdit;
  final bool isShorts;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: AppPadding.small,
        itemCount: medias.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: isShorts ? .5 : 1),
        itemBuilder: (context, index) {
          final media = medias[index];
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: GestureDetector(
              onTap: () {
                if (isShorts) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => VideoReelPage(
                      index: index,
                      reels: medias
                    ),
                  ));
                  return;
                }
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return AllPostView(initialIndex: index, posts: medias);
                  },
                ));
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: CachedNetworkImage(
                  imageUrl: isShorts
                      ? media.extra ?? ''
                      : medias[index].postImageUrl[0],
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        });
  }
}
