import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/widgets/app_related/common_text.dart';

class AppLoadingGif extends StatelessWidget {
  const AppLoadingGif({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppAssetsConst.buildProfile,
            height: 125,
            width: 125,
          ),
          const CustomText('Building Your Profile..')
        ],
      ),
    );
  }
}
