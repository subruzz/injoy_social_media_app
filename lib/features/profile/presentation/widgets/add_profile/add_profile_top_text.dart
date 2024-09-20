import 'package:flutter/material.dart';
import 'package:social_media_app/core/widgets/common/common_text.dart';

class AddProfileTopText extends StatelessWidget {
  const AddProfileTopText({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomText(
        text:  'Fill Your Profile',
      style: Theme.of(context).textTheme.displaySmall,
    );
  }
}
