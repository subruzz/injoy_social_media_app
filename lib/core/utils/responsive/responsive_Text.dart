import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';

/// A utility class for generating responsive text styles based on screen size.
///
/// This class provides a method to adjust text styles dynamically,
/// ensuring that font sizes are appropriate for mobile, tablet, and desktop devices.
class ResponsiveText {
  ResponsiveText._(); // Private constructor to prevent instantiation.

  /// Returns a responsive [TextStyle] based on the provided [baseStyle] and the current screen size.
  ///
  /// The method modifies the font size depending on whether the device is mobile, tablet, or desktop:
  /// - On mobile, the font size is adjusted using [ScreenUtil].
  /// - On tablet, the font size is increased by 10%.
  /// - On desktop, the font size is increased by 20%.
  ///
  /// [context] is used to determine the current device type, and [baseStyle] is the original style
  /// to be modified.
  static TextStyle getResponsiveTextStyle(
      BuildContext context, TextStyle baseStyle) {
    // Determine the base font size; defaults to 14 if not specified.
    double fontSize =
        !isThatMobile ? baseStyle.fontSize ?? 14 : baseStyle.fontSize ?? 14.sp;

    // Adjust font size based on the device type.
    if (!isThatMobile) {
      fontSize = fontSize * 1.2; // Increase font size for desktop.
    } else if (isThatTab) {
      fontSize = fontSize * 1.1; // Slightly increase font size for tablet.
    } else {
      fontSize = fontSize; // Use the base size for mobile.
    }

    // Return the modified text style with the new font size.
    return baseStyle.copyWith(fontSize: !isThatMobile ? fontSize : fontSize.sp);
  }
}
