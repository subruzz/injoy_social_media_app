import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';

class AiGeneratingShimmer extends StatelessWidget {
  const AiGeneratingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.onlyLeftMedium,
      child: Shimmer.fromColors(
        baseColor: Colors.deepPurple,
        highlightColor: Colors.pinkAccent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Star Icon
            AppSizedBox.sizedBox10H, // First Shimmer Line
            Container(
              height: 10,
              width: 100,
              color: Colors.white,
            ),
            AppSizedBox.sizedBox5H, // Spacing
            // Second Shimmer Line
            Container(
              height: 10,
              width: 150,
              color: Colors.white,
            ),
            AppSizedBox.sizedBox5H, // Spacing
            // Third Shimmer Line
            Container(
              height: 10,
              width: 200,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
