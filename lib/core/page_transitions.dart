// app_page_transition.dart

import 'package:flutter/material.dart';

class AppPageTransitions {
  // Right-to-Left Transition
  static Route rightToLeft(Widget screen,
      {Duration duration = const Duration(milliseconds: 350)}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: duration,
    );
  }

  // Left-to-Right Transition
  static Route leftToRight(Widget screen,
      {Duration duration = const Duration(milliseconds: 350)}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: duration,
    );
  }

  // Bottom-to-Top Transition
  static Route bottomToTop(Widget screen,
      {Duration duration = const Duration(milliseconds: 350)}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: duration,
    );
  }

  // Top-to-Bottom Transition
  static Route topToBottom(Widget screen,
      {Duration duration = const Duration(milliseconds: 350)}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, -1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: duration,
    );
  }

  // Fade Transition
  static Route fade(Widget screen,
      {Duration duration = const Duration(milliseconds: 350)}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
      transitionDuration: duration,
    );
  }

  // Scale Transition
  static Route scale(Widget screen,
      {Duration duration = const Duration(milliseconds: 350)}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: animation,
          child: child,
        );
      },
      transitionDuration: duration,
    );
  }

  // Rotation Transition
  static Route rotation(Widget screen,
      {Duration duration = const Duration(milliseconds: 350)}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return RotationTransition(
          turns: animation,
          child: child,
        );
      },
      transitionDuration: duration,
    );
  }

  // Custom Transition with Customizable TransitionBuilder
  static Route custom(
    Widget screen, {
    required RouteTransitionsBuilder transitionsBuilder,
    Duration duration = const Duration(milliseconds: 350),
  }) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: transitionsBuilder,
      transitionDuration: duration,
    );
  } // Size Transition

  static Route size(Widget screen,
      {Duration duration = const Duration(milliseconds: 350)}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return Align(
          child: SizeTransition(
            sizeFactor: animation,
            child: child,
          ),
        );
      },
      transitionDuration: duration,
    );
  }

  // Zoom Transition (combination of scale and fade)
  static Route zoom(Widget screen,
      {Duration duration = const Duration(milliseconds: 350)}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: animation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      transitionDuration: duration,
    );
  }

  // Flip Transition
  static Route flip(Widget screen,
      {Duration duration = const Duration(milliseconds: 350)}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return RotationTransition(
          turns: Tween(begin: 0.0, end: 1.0).animate(animation),
          child: child,
        );
      },
      transitionDuration: duration,
    );
  }

  // Slide Transition with Custom Direction
  static Route slideWithCustomDirection(Widget screen, Offset begin,
      {Duration duration = const Duration(milliseconds: 350)}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween = Tween(begin: begin, end: Offset.zero)
            .chain(CurveTween(curve: Curves.easeInOut));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: duration,
    );
  }

  // Hero Transition
  static Route hero(Widget screen,
      {Duration duration = const Duration(milliseconds: 350)}) {
    return MaterialPageRoute(
      builder: (context) => screen,
      settings: RouteSettings(arguments: screen),
      maintainState: true,
      fullscreenDialog: true,
    );
  }
}
