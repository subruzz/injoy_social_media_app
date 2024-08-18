import 'package:flutter/material.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';

class Messenger {
  static final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar({
    String message = 'An unexpected error occurred, please try again!',
    double snackBarWidth = 300.0, // Add a parameter for width
  }) {
    // Remove MediaQuery to avoid errors when no context is available
    scaffoldKey.currentState!.clearSnackBars();
    scaffoldKey.currentState!.showSnackBar(
      SnackBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        duration: const Duration(milliseconds: 4000),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppDarkColor().secondaryBackground,
        margin: const EdgeInsets.only(
            right: 20, left: 20, top: 30, bottom: 20), // Adjust top margin
        content: SizedBox(
          width: isThatTabOrDeskTop
              ? snackBarWidth
              : null, // Set the width of the Container
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Image.asset(
                  'assets/images/app_logo.png',
                  height: 24, // Adjust image height
                  width: 24, // Adjust image width
                ),
              ),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    color: Colors.white.withOpacity(.8),
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
