import 'package:flutter/material.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/widgets/animation/animations.dart';

import '../../../../../../core/const/app_config/app_sizedbox.dart';
import '../../../../../../core/const/assets/app_assets.dart';
import '../../../../../../core/widgets/common/user_profile.dart';

class AiChatTopBar extends StatelessWidget {
  const AiChatTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      snap: true,
      pinned: true,
      elevation: 2,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      titleSpacing: 0,
      title: Row(
        children: [
          const CircularUserProfile(
            wantCustomAsset: true,
            customAsset: AppAssetsConst.ai,
            size: 20,
          ),
          AppSizedBox.sizedBox10W,
          isThatMobile
              ? const TextShimmerAnimation(
                  repeat: false,
                  applySlide: false,
                  needFade: false,
                  child: AiName())
              : const AiName()
        ],
      ),
    );
  }
}

class AiName extends StatelessWidget {
  const AiName({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Inaya',
      style: Theme.of(context)
          .textTheme
          .headlineMedium
          ?.copyWith(fontWeight: FontWeight.w700),
    );
  }
}
