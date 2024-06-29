import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class PageViewIndicator extends StatelessWidget {
  const PageViewIndicator(
      {super.key, required this.pageController, required this.count});
  final PageController pageController;
  final int count;
  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: pageController,
      count: count,
      effect: WormEffect(
        // Choose your desired visual effect
        activeDotColor: AppDarkColor().indicatorColor,
        dotColor: AppDarkColor().softBackground,
        dotHeight: 10,
        dotWidth: 10,
      ),
    );
  }
}
