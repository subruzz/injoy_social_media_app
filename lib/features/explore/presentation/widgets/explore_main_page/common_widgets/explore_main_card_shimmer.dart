import 'package:flutter/material.dart';
import 'package:social_media_app/features/explore/presentation/widgets/explore_main_page/common_widgets/explore_user_card_shimmer_item.dart';

class ExploreMainCardShimmer extends StatelessWidget {
  const ExploreMainCardShimmer({super.key, required this.controller});
  final PageController controller;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: PageView.builder(
      physics: const BouncingScrollPhysics(),
      controller: controller,
      itemCount: 4,
      itemBuilder: (context, index) => const ShimmerUserCard(),
    ));
  }
}
