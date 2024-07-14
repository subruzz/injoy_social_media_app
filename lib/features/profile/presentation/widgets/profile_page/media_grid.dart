import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';

class MediaGrid extends StatelessWidget {
  const MediaGrid({super.key, required this.medias});
  final List<PostEntity> medias;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: AppPadding.small,
      itemCount: medias.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(2.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: CachedNetworkImage(
            imageUrl: medias[index].postImageUrl[0],
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}