import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_padding.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/features/status/presentation/pages/create_status_page.dart';

class CreateStatusButton extends StatelessWidget {
  const CreateStatusButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const StatusCreationPage(),
        ));
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: AppDarkColor().buttonBackground),
        child: Padding(
          padding: AppPadding.extraSmall,
          child: Icon(
            Icons.add,
            color: AppDarkColor().background,
            size: 12,
          ),
        ),
      ),
    );
  }
}
