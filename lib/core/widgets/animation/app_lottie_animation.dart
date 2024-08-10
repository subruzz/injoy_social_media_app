import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppLottieAnimation extends StatelessWidget {
  const AppLottieAnimation({super.key, required this.lottie});
  final String lottie;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(lottie,
          fit: BoxFit.cover, width: double.infinity),
    );
  }
}
