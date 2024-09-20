import 'package:flutter/material.dart';
import 'package:social_media_app/core/utils/responsive/responsive_helper.dart';
import 'package:social_media_app/core/widgets/common/common_text.dart';

class WelcomeTitle extends StatelessWidget {
  final String text;
  const WelcomeTitle({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return CustomText(
      letterSpacing: 4,
      text: text,
      style: Theme.of(context)
          .textTheme
          .displayLarge
          ?.copyWith(fontSize: Responsive.deskTopAndTab(context) ? 26 : null),
    );
  }
}
