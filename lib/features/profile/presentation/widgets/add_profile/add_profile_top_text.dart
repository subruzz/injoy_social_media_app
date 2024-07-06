import 'package:flutter/material.dart';
import 'package:social_media_app/core/widgets/app_related/common_text.dart';

class AddProfileTopText extends StatelessWidget {
  const AddProfileTopText({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      'Fill Your Profile',
      style: Theme.of(context).textTheme.displaySmall,
    );
  }
}