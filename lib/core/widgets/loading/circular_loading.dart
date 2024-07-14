import 'package:flutter/material.dart';

class CircularLoading extends StatelessWidget {
  const CircularLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 25,
      width: 25,
      child: CircularProgressIndicator.adaptive(),
    );
  }
}

class CircularLoadingGrey extends StatelessWidget {
  const CircularLoadingGrey({super.key, this.size = 35});
  final double size;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: const CircularProgressIndicator(
        valueColor:
            AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 134, 132, 132)),
        strokeWidth: 2,
      ),
    );
  }
}
