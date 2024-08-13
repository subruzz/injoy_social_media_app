// app_page_transition.dart

import 'package:flutter/material.dart';

class AppPageTransitions {
  // Subtle Scale Transition
  static Route subtleScale(Widget screen,
      {Duration duration = const Duration(milliseconds: 350)}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 1.05, end: 1.0)
              .chain(CurveTween(curve: Curves.easeInOut))
              .animate(animation),
          child: child,
        );
      },
      transitionDuration: duration,
    );
  }

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
  } // Slide and Fade Transition (Combination)

  static Route slideAndFade(Widget screen,
      {Duration duration = const Duration(milliseconds: 350)}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: animation.drive(
                Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                    .chain(CurveTween(curve: Curves.easeInOut))),
            child: child,
          ),
        );
      },
      transitionDuration: duration,
    );
  } // Slide and Scale Transition (Combination)

  static Route slideAndScale(Widget screen,
      {Duration duration = const Duration(milliseconds: 350)}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: animation.drive(Tween(begin: 0.9, end: 1.0)
              .chain(CurveTween(curve: Curves.easeInOut))),
          child: SlideTransition(
            position: animation.drive(
                Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                    .chain(CurveTween(curve: Curves.easeInOut))),
            child: child,
          ),
        );
      },
      transitionDuration: duration,
    );
  } // Slide and Rotation Transition (Combination)

  static Route slideAndRotate(Widget screen,
      {Duration duration = const Duration(milliseconds: 350)}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return RotationTransition(
          turns: animation.drive(Tween(begin: 0.0, end: 1.0)
              .chain(CurveTween(curve: Curves.easeInOut))),
          child: SlideTransition(
            position: animation.drive(
                Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                    .chain(CurveTween(curve: Curves.easeInOut))),
            child: child,
          ),
        );
      },
      transitionDuration: duration,
    );
  } // Flip and Scale Transition (Combination)

  static Route flipAndScale(Widget screen,
      {Duration duration = const Duration(milliseconds: 350)}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: animation.drive(Tween(begin: 0.8, end: 1.0)
              .chain(CurveTween(curve: Curves.easeInOut))),
          child: RotationTransition(
            turns: animation.drive(Tween(begin: 0.0, end: 1.0)
                .chain(CurveTween(curve: Curves.easeInOut))),
            child: child,
          ),
        );
      },
      transitionDuration: duration,
    );
  } // Draggable Transition

  static Route draggable(Widget screen,
      {Duration duration = const Duration(milliseconds: 350)}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: duration,
    );
  } // Page Curl Transition

  static Route pageCurl(Widget screen,
      {Duration duration = const Duration(milliseconds: 350)}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        );

        return AnimatedBuilder(
          animation: curvedAnimation,
          builder: (context, child) {
            final double value = curvedAnimation.value;
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationX(value * 3.14),
              child: child,
            );
          },
          child: child,
        );
      },
      transitionDuration: duration,
    );
  } // Enhanced Top-to-Bottom Transition with Scale and Fade

  static Route enhancedTopToBottom(Widget screen,
      {Duration duration = const Duration(milliseconds: 350)}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, -1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var scaleTween =
            Tween(begin: 0.8, end: 1.0).chain(CurveTween(curve: curve));
        var opacityTween =
            Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));

        var offsetAnimation = animation.drive(tween);
        var scaleAnimation = animation.drive(scaleTween);
        var opacityAnimation = animation.drive(opacityTween);

        return FadeTransition(
          opacity: opacityAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: SlideTransition(
              position: offsetAnimation,
              child: child,
            ),
          ),
        );
      },
      transitionDuration: duration,
    );
  }

// Enhanced Bottom-to-Top Transition with Rotation and Fade
  static Route enhancedBottomToTop(Widget screen,
      {Duration duration = const Duration(milliseconds: 350)}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var rotationTween =
            Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));
        var opacityTween =
            Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));

        var offsetAnimation = animation.drive(tween);
        var rotationAnimation = animation.drive(rotationTween);
        var opacityAnimation = animation.drive(opacityTween);

        return FadeTransition(
          opacity: opacityAnimation,
          child: RotationTransition(
            turns: rotationAnimation,
            child: SlideTransition(
              position: offsetAnimation,
              child: child,
            ),
          ),
        );
      },
      transitionDuration: duration,
    );
  }

// Enhanced Left-to-Right Transition with Scale and Fade
  // Enhanced Left-to-Right Transition with Subtle Scaling and Fade
  static Route enhancedLeftToRight(Widget screen,
      {Duration duration = const Duration(milliseconds: 350)}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var slideTween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var scaleTween =
            Tween(begin: 0.8, end: 1.0).chain(CurveTween(curve: curve));
        var opacityTween =
            Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));

        var slideAnimation = animation.drive(slideTween);
        var scaleAnimation = animation.drive(scaleTween);
        var opacityAnimation = animation.drive(opacityTween);

        return FadeTransition(
          opacity: opacityAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: SlideTransition(
              position: slideAnimation,
              child: child,
            ),
          ),
        );
      },
      transitionDuration: duration,
    );
  }

// Enhanced Right-to-Left Transition with Subtle Scaling and Fade
  static Route enhancedRightToLeft(Widget screen,
      {Duration duration = const Duration(milliseconds: 350)}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var slideTween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var scaleTween =
            Tween(begin: 0.9, end: 1.0).chain(CurveTween(curve: curve));
        var opacityTween =
            Tween(begin: 0.0, end: 1.0).chain(CurveTween(curve: curve));

        var slideAnimation = animation.drive(slideTween);
        var scaleAnimation = animation.drive(scaleTween);
        var opacityAnimation = animation.drive(opacityTween);

        return FadeTransition(
          opacity: opacityAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: SlideTransition(
              position: slideAnimation,
              child: child,
            ),
          ),
        );
      },
      transitionDuration: duration,
    );
  }
}
