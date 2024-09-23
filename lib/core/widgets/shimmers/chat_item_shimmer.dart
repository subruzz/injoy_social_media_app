import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class ChatCallItemShimmer extends StatelessWidget {
  const ChatCallItemShimmer({super.key, this.itemCount = 19});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: AppDarkColor().secondaryBackground,
          highlightColor: AppDarkColor().softBackground,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 9.0),
            child: ListTile(
              leading: const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 16,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 100,
                    height: 12,
                    color: Colors.white,
                  ),
                ],
              ),
              subtitle: Container(
                width: double.infinity,
                height: 12,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
