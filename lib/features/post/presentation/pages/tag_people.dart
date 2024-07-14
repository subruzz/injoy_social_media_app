import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/core/widgets/page_view.dart';

class TagPeoplePage extends StatelessWidget {
  TagPeoplePage({super.key, required this.selectedAssets});
  final List<AssetEntity> selectedAssets;
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
            child: CustomPageView(
          pageController: pageController,
          selectedStatusAssets: selectedAssets,
        ))
      ],
    ));
  }
}
