import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/widgets/app_related/common_text.dart';

import '../../common_widget/tag_location_symbol.dart';

class TagLocationItem extends StatelessWidget {
  final String title;
  final int postCount;
  final bool isLocation;
  final bool giveOne;
  final double size;
  const TagLocationItem({
    super.key,
    required this.title,
    this.size = 30,
    this.giveOne = false,
    this.isLocation = false,
    required this.postCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: !giveOne
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TagLocationSymbol(
                  size: size,
                  child: isLocation
                      ? Icon(
                          size: size,
                          Icons.location_on_outlined,
                          color: Colors.white,
                        )
                      : Text(
                          '#',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: size,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                ),
                AppSizedBox.sizedBox15W,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        title,
                        maxLines: 2,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 4),
                      CustomText(
                        '$postCount posts',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TagLocationSymbol(
                  size: size,
                  child: isLocation
                      ? const Icon(
                          size: 30,
                          Icons.location_on_outlined,
                          color: Colors.white,
                        )
                      : const Text(
                          '#',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                ),
                AppSizedBox.sizedBox15W,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 4),
                    CustomText(
                      '$postCount posts',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
