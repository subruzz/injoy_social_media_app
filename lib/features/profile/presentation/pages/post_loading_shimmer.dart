import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class PostLoadingShimmer extends StatelessWidget {
  const PostLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: AppPadding.small,
        itemCount: 5,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) => Shimmer.fromColors(
              baseColor: AppDarkColor().secondaryBackground,
              highlightColor: AppDarkColor().softBackground,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ));
  }
}
