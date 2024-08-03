import 'package:flutter/material.dart';
import 'package:social_media_app/features/post_status_feed/presentation/widgets/welcome_card/common_widgets/welcome_user_card_shimmer_item.dart';

class WelcomeMainCardShimmer extends StatelessWidget {
  const WelcomeMainCardShimmer({super.key, required this.controller});
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
