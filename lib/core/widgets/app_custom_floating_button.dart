import 'package:flutter/material.dart';

class AppCustomFloatingButton extends StatelessWidget {
  const AppCustomFloatingButton(
      {super.key, required this.onPressed, required this.child});
  final VoidCallback onPressed;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: child,
    );
  }
}
