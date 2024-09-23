
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shimmer/shimmer.dart';

import '../../theme/color/app_colors.dart';

class PostStaggeredViewShimmer extends StatelessWidget {
  const PostStaggeredViewShimmer({super.key, this.itemCount = 10});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppDarkColor().secondaryBackground,
      highlightColor: AppDarkColor().softBackground,
      child: MasonryGridView.builder(
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          final double tileHeight =
              index % 3 == 0 ? 1.5 : 1; // Simulate video posts
          final double aspectRatio = 1 / tileHeight;

          return Padding(
            padding: const EdgeInsets.all(3.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: AspectRatio(
                aspectRatio: aspectRatio,
                child: Container(
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
