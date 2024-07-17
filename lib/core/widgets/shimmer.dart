import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';

class ShimmerEachPost extends StatelessWidget {
  const ShimmerEachPost({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return CustomAppPadding(
          padding: const EdgeInsets.only(left: 20.0, right: 10, bottom: 25),
          child: Shimmer.fromColors(
            baseColor: AppDarkColor().secondaryBackground,
            highlightColor: AppDarkColor().secondaryBackground,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                      ),
                    ),
                    AppSizedBox.sizedBox5W,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            width: 100,
                            height: 20,
                            color: Colors.white,
                          ),
                        ),
                        AppSizedBox.sizedBox5H,
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            width: 50,
                            height: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                AppSizedBox.sizedBox10H,
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: double.infinity,
                    height: 20,
                    color: Colors.white,
                  ),
                ),
                AppSizedBox.sizedBox5H,
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 100,
                    height: 20,
                    color: Colors.white,
                  ),
                ),
                AppSizedBox.sizedBox5H,
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.white,
                  ),
                ),
                AppSizedBox.sizedBox5H,
              ],
            ),
          ),
        );
      },
    );
  }
}
