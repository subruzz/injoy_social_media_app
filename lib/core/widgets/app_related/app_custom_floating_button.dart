import 'package:flutter/material.dart';

class AppCustomFloatingButton extends StatelessWidget {
  const AppCustomFloatingButton(
      {super.key, this.shape, required this.onPressed, required this.child});
  final VoidCallback onPressed;
  final Widget child;
  final ShapeBorder? shape;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      shape: shape,
      child: child,
    );
  }
}
