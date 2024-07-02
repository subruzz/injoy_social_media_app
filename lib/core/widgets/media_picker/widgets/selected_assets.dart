import 'package:flutter/cupertino.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/core/widgets/empty_display.dart';
import 'package:social_media_app/core/widgets/page_view.dart';

class SelectedAssetsPageView extends StatelessWidget {
  const SelectedAssetsPageView(
      {super.key,
      required this.pageController,
      this.isPost = false,
      required this.selectedAssets});
  final PageController pageController;
  final ValueNotifier<List<AssetEntity>> selectedAssets;
  final bool isPost;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedAssets,
      builder: (context, value, child) {
        return selectedAssets.value.isNotEmpty
            ?!isPost? CustomPageView(
                  pageController: pageController,
                  selectedStatusAssets: selectedAssets.value,
                ): Expanded(
                child: CustomPageView(
                  pageController: pageController,
                  selectedStatusAssets: selectedAssets.value,
                ),
              )
            : const EmptyDisplay();
      },
    );
  }
}
