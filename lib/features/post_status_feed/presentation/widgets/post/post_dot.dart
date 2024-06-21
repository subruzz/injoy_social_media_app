import 'package:flutter/material.dart';

class PostDot extends StatelessWidget {
  const PostDot({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '•',
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 30),
    );
  }
}
