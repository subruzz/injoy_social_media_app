import 'package:flutter/cupertino.dart';

class AppCustomPadding extends StatelessWidget {
  const AppCustomPadding(
      {super.key, required this.padding, required this.child});
  final EdgeInsets padding;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(padding: padding, child: child);
  }
}
