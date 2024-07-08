import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class ShimmerEachPost extends StatelessWidget {
  const ShimmerEachPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 10, bottom: 25),
      child: Shimmer.fromColors(
        baseColor: AppDarkColor().secondaryBackground,
        highlightColor: AppDarkColor().secondaryBackground,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
            ),
            AppSizedBox.sizedBox5W,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 100,
                            height: 20,
                            color: Colors.white,
                          ),
                          AppSizedBox.sizedBox5W,
                          const CircleAvatar(
                            radius: 2,
                            backgroundColor: Colors.white,
                          ),
                          AppSizedBox.sizedBox5W,
                          Container(
                            width: 50,
                            height: 20,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  AppSizedBox.sizedBox10H,
                  Container(
                    width: double.infinity,
                    height: 20,
                    color: Colors.white,
                  ),
                  AppSizedBox.sizedBox5H,
                  Container(
                    width: 100,
                    height: 20,
                    color: Colors.white,
                  ),
                  AppSizedBox.sizedBox5H,
                  Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.white,
                  ),
                  AppSizedBox.sizedBox5H,
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 35,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
