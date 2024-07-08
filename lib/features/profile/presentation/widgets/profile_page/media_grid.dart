import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MediaGrid extends StatelessWidget {
  const MediaGrid({super.key, required this.medias});
  final List<String> medias;
  @override
  Widget build(BuildContext context) {
    return MasonryGridView.builder(
        itemCount: medias.length,
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemBuilder: (context, index) => CachedNetworkImage(
              imageUrl: medias[index],
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ));
  }
}
