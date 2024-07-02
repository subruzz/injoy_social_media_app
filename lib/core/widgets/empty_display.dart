import 'package:flutter/cupertino.dart';

class EmptyDisplay extends StatelessWidget {
  const EmptyDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 0,
      width: 0,
    );
  }
}
