import 'package:flutter/cupertino.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:social_media_app/core/widgets/app_related/empty_display.dart';
import 'package:social_media_app/features/post/presentation/widgets/select_post/page_view_indicator.dart';

class SelectedAssetsIndicator extends StatelessWidget {
  const SelectedAssetsIndicator(
      {super.key,
      this.isPost = false,
      required this.pageController,
      required this.selectedAssets});
  final PageController pageController;
  final ValueNotifier<List<AssetEntity>> selectedAssets;
  final bool isPost;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedAssets,
      builder: (context, value, child) {
        return value.length > 1
            ? isPost
                ? PageViewIndicator(
                    count: value.length,
                    pageController: pageController,
                  )
                : Positioned(
                    bottom: 100,
                    child: PageViewIndicator(
                      count: value.length,
                      pageController: pageController,
                    ),
                  )
            : const EmptyDisplay();
      },
    );
  }
}
