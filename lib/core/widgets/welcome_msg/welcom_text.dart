import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/core/widgets/app_related/common_text.dart';

class WelcomeTitle extends StatelessWidget {
  final String text;
  const WelcomeTitle({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: const Duration(milliseconds: 0),
      duration: const Duration(milliseconds: 0),
      child: CustomText(
        letterSpacing: 4,
        text,
        style: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }
}