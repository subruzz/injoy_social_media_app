import 'package:flutter/material.dart';

class MulitplePostIndicator extends StatelessWidget {
  const MulitplePostIndicator(
      {super.key, required this.showIndicator, required this.child});
  final bool showIndicator;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        child,
        if (showIndicator)
          const Padding(
            padding: EdgeInsets.all(4.0),
            child: Icon(
              Icons.photo_library,
              color: Colors.white,
            ),
          )
      ],
    );
  }
}
