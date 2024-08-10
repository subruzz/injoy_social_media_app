import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TextShimmerAnimation extends StatelessWidget {
  final Widget child;
  final bool repeat;
  final bool applySlide;
  final Duration shimmerDuration;
  final Color shimmerColor;
  final Duration fadeInDuration;
  final Curve fadeInCurve;
  final Duration slideDuration;
  final Curve slideCurve;
  final bool needFade;
  const TextShimmerAnimation({
    super.key,
    required this.child,
    this.needFade = true,
    this.repeat = true,
    this.applySlide = true,
    this.shimmerDuration = const Duration(milliseconds: 1200),
    this.shimmerColor = const Color(0xFF80DDFF),
    this.fadeInDuration = const Duration(milliseconds: 1200),
    this.fadeInCurve = Curves.easeOutQuad,
    this.slideDuration = const Duration(milliseconds: 600),
    this.slideCurve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    var animatedWidget = child
        .animate(onPlay: repeat ? (controller) => controller.repeat() : null)
        .shimmer(duration: shimmerDuration, color: shimmerColor)
        .animate();
    if (needFade) {
      animatedWidget =
          animatedWidget.fadeIn(duration: fadeInDuration, curve: fadeInCurve);
    }

    // Conditionally apply slide animation
    if (applySlide) {
      animatedWidget =
          animatedWidget.slide(duration: slideDuration, curve: slideCurve);
    }

    return animatedWidget;
  }
}

class SlideAnimation extends StatelessWidget {
  final Widget child;
  final bool repeat;
  final Duration slideDuration;
  final Curve slideCurve;

  const SlideAnimation({
    super.key,
    required this.child,
    this.repeat = false,
    this.slideDuration = const Duration(milliseconds: 600),
    this.slideCurve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    var animatedWidget = child
        .animate(onPlay: repeat ? (controller) => controller.repeat() : null)
        .slide(duration: slideDuration, curve: slideCurve);

    return animatedWidget;
  }
}

class FadeInAnimation extends StatelessWidget {
  final Widget child;
  final bool repeat;
  final Duration fadeInDuration;
  final Curve fadeInCurve;

  const FadeInAnimation({
    super.key,
    required this.child,
    this.repeat = false,
    this.fadeInDuration = const Duration(milliseconds: 1200),
    this.fadeInCurve = Curves.easeOutQuad,
  });

  @override
  Widget build(BuildContext context) {
    var animatedWidget = child
        .animate(onPlay: repeat ? (controller) => controller.repeat() : null)
        .fadeIn(duration: fadeInDuration, curve: fadeInCurve);

    return animatedWidget;
  }
}
