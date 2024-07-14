import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:social_media_app/core/widgets/app_related/common_text.dart';
import 'package:social_media_app/features/explore/presentation/widgets/common_widgets/tag_location_symbol.dart';

class TagLocationItem extends StatelessWidget {
  final String title;
  final int postCount;
  final bool isLocation;
  const TagLocationItem({
    super.key,
    required this.title,
    this.isLocation = false,
    required this.postCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TagLocationSymbol(
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
          const SizedBox(width: 16),
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
