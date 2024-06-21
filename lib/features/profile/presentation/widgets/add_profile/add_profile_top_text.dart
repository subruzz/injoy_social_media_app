import 'package:flutter/material.dart';

class AddProfileTopText extends StatelessWidget {
  const AddProfileTopText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Fill Your Profile',
      style: Theme.of(context).textTheme.displaySmall,
    );
  }
}
