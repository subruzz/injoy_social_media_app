import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';

class AppErrorGif extends StatelessWidget {
  const AppErrorGif({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppAssetsConst.errorGif,
          height: 125,
          width: 125,
        ),
        const Text('oops,Something went wrong')
      ],
    );
  }
}
