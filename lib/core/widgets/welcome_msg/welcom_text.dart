import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

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
      child: Text(
        text,
        style: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }
}
