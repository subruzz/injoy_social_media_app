import 'package:flutter/material.dart';

/// A responsive widget that builds different layouts based on the device's screen size.
///
/// This widget allows you to specify separate UI components for mobile, tablet, and desktop devices,
/// enabling a more tailored user experience based on the screen width.
///
/// Example usage:
/// ```dart
/// Responsive(
///   mobile: MobileLayout(),
///   tablet: TabletLayout(),
///   desktop: DesktopLayout(),
/// )
/// ```
class Responsive extends StatelessWidget {
  final Widget mobile;        // The widget to display on mobile devices.
  final Widget? tablet;       // The widget to display on tablet devices (optional).
  final Widget desktop;       // The widget to display on desktop devices.

  const Responsive({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  /// Checks if the current device is a mobile device.
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 800;

  /// Checks if the current device is a tablet.
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 800;

  /// Checks if the current device is a desktop.
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  /// Checks if the current device is either a desktop or a tablet.
  static bool deskTopAndTab(BuildContext context) =>
      MediaQuery.of(context).size.width >= 800;

  /// Checks if the current device falls between mobile and tablet specifications.
  static bool isBtwMobAndTab(BuildContext context) =>
      MediaQuery.of(context).size.width >= 500 &&
      MediaQuery.of(context).size.width < 800;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    // Determine which widget to display based on the screen width.
    if (size.width >= 1100) {
      return desktop; // Desktop layout
    } else if (size.width >= 800 && tablet != null) {
      return tablet!; // Tablet layout
    } else {
      return mobile; // Mobile layout
    }
  }
}
