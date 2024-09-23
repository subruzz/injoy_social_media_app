import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/enums/media_picker_type.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

import '../../../../core/utils/routes/tranistions/app_routes_const.dart';

class NoPersonalPostWidget extends StatelessWidget {
  const NoPersonalPostWidget({super.key, this.isShorts = false});
  final bool isShorts;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      children: [
        AppSizedBox.sizedBox50H,
        IconButton(
          style: IconButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                width: 1.5,
                color: theme.colorScheme.onSecondary,
              ),
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(
              context,
              MyAppRouteConst.mediaPickerRoute,
              arguments: {
                'pickerType':
                    isShorts ? MediaPickerType.reels : MediaPickerType.post
              },
            );
          },
          icon: Icon(Icons.add, size: 40, color: AppDarkColor().secondaryText),
        ),
        AppSizedBox.sizedBox10H,
        Text(
          "You haven't posted anything yet!",
          style: TextStyle(fontSize: 18, color: AppDarkColor().primaryText),
        ),
        AppSizedBox.sizedBox5H,
        Text(
          'Start sharing your moments\nwith others',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: AppDarkColor().secondaryText),
        ),
      ],
    );
  }
}
