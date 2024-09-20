import 'package:flutter/material.dart';

/// A custom page route that creates a dialog with a hero animation.
///
/// This class extends [PageRoute] to provide a dialog-style route that can be 
/// used for displaying modal content in a way that allows for smooth 
/// transitions and animations. It can be customized with a background color 
/// and is dismissible by tapping outside of the dialog.
///
/// Example usage:
/// ```dart
/// showDialog(
///   context: context,
///   builder: (context) {
///     return HeroDialogRoute(
///       backgroundColor: Colors.white,
///       builder: (context) => YourDialogWidget(),
///     );
///   },
/// );
/// ```
class HeroDialogRoute<T> extends PageRoute<T> {
  final Color? backgroundColor;  // The background color of the dialog.

  HeroDialogRoute({
    this.backgroundColor,
    required WidgetBuilder builder,
    super.settings,
    super.fullscreenDialog,
  }) : _builder = builder;

  final WidgetBuilder _builder;

  @override
  bool get opaque => false;  // Allows the background to show through.

  @override
  bool get barrierDismissible => true;  // Allows dismissing the dialog by tapping outside.

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);  // Duration of the transition animation.

  @override
  bool get maintainState => true;  // Maintains the state of the route.

  @override
  Color get barrierColor => backgroundColor ?? Colors.black54;  // Color of the barrier behind the dialog.

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;  // No additional transitions applied; simply returns the child widget.
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return _builder(context);  // Builds the dialog page using the provided builder.
  }

  @override
  String get barrierLabel => 'Popup dialog open';  // Accessibility label for the barrier.
}
