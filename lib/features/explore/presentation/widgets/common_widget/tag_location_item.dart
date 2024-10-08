import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/widgets/common/common_text.dart';
import 'package:social_media_app/features/explore/presentation/widgets/common_widget/tag_location_symbol.dart';

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
                          textAlign: TextAlign.start,
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
                        textAlign: TextAlign.start,
                        text: title,
                        maxLines: 2,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: isThatTabOrDeskTop ? 16 : null),
                      ),
                      const SizedBox(height: 4),
                      CustomText(
                        textAlign: TextAlign.start,
                        text: '$postCount posts',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: isThatTabOrDeskTop ? 13 : null),
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
                      text: title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 4),
                    CustomText(
                      text: '$postCount posts',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
