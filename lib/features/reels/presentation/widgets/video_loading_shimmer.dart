import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class VideoLoadingShimmer extends StatelessWidget {
  const VideoLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[500]!,
          highlightColor: const Color(0xFFAFAFAF),
          child: Container(
            width: double.infinity,
            height: double.maxFinite,
            color: Colors.grey,
          ),
        ),
        Shimmer.fromColors(
          baseColor: Colors.grey[600]!,
          highlightColor: const Color(0xFFAFAFAF),
          child: Padding(
            padding: const EdgeInsetsDirectional.only(
                end: 25.0, bottom: 20, start: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Color(0xff282828),
                ),
                const SizedBox(height: 5),
                Container(
                    height: 15, width: 150, color: const Color(0xff282828)),
                const SizedBox(height: 5),
                Container(
                    height: 15, width: 200, color: const Color(0xff282828)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
