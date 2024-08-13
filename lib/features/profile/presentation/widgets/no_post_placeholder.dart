import 'package:flutter/material.dart';
import 'package:social_media_app/core/utils/routes/tranistions/app_routes_const.dart';
import 'package:social_media_app/core/theme/widget_themes/text_theme.dart';

class NoPostsPlaceholder extends StatelessWidget {
  const NoPostsPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        Text(
          'No posts yet.\nStart sharing your moments!',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        TextButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                MyAppRouteConst.mediaPickerRoute,
                arguments: {'isPost': true},
              );
            },
            child: Text('Start Creating',
                style: AppTextTheme.labelMediumRedVariant.labelMedium))
      ],
    );
  }
}
