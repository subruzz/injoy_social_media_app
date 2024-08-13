import 'package:flutter/material.dart';
import 'package:social_media_app/core/widgets/common/add_at_symbol.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/features/explore/presentation/widgets/common_widget/tag_location_item.dart';

class HashtagPostsTopWidgetSection extends StatelessWidget {
  const HashtagPostsTopWidgetSection(
      {super.key, required this.hashTagName, required this.hashTagPostCount});
  final String hashTagName;
  final int hashTagPostCount;
  @override
  Widget build(BuildContext context) {
    return CustomAppPadding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TagLocationItem(
            size: 35,
            title: addHashSymbol(hashTagName),
            postCount: hashTagPostCount,
            giveOne: true,
          ),
          AppSizedBox.sizedBox5H,
        ],
      ),
    );
  }
}
