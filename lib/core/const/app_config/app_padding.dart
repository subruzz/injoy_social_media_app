import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A utility class for defining consistent `EdgeInsets` values
/// throughout the app, utilizing the `FlutterScreenUtil` package 
/// for responsive scaling.
///
/// This class contains various factory methods and predefined 
/// `EdgeInsets` values for common use cases like buttons, cards, 
/// lists, and more.
final class AppPadding {
  /// A private constructor to prevent instantiation. 
  /// This class is intended to be used statically.
  AppPadding._();

  /// Returns `EdgeInsets` with the same value for all sides.
  static EdgeInsets all(double value) => EdgeInsets.all(value.w);

  /// Returns `EdgeInsets` with specified horizontal and vertical padding.
  static EdgeInsets symmetric(
          {double horizontal = 0.0, double vertical = 0.0}) =>
      EdgeInsets.symmetric(horizontal: horizontal.w, vertical: vertical.w);

  /// Returns `EdgeInsets` with specified values for each side.
  static EdgeInsets only(
          {double left = 0.0,
          double top = 0.0,
          double right = 0.0,
          double bottom = 0.0}) =>
      EdgeInsets.only(
          left: left.w, top: top.w, right: right.w, bottom: bottom.w);

  // Predefined padding values for common use cases
  static EdgeInsets extraSmall = all(4.0);
  static EdgeInsets small = all(8.0);
  static EdgeInsets medium = all(16.0);
  static EdgeInsets large = all(24.0);
  static EdgeInsets extraLarge = all(32.0);

  // Horizontal padding presets
  static EdgeInsets horizontalExtraSmall = symmetric(horizontal: 4.0);
  static EdgeInsets horizontalSmall = symmetric(horizontal: 8.0);
  static EdgeInsets horizontalMedium = symmetric(horizontal: 16.0);
  static EdgeInsets horizontalLarge = symmetric(horizontal: 24.0);
  static EdgeInsets horizontalExtraLarge = symmetric(horizontal: 32.0);

  // Vertical padding presets
  static EdgeInsets verticalExtraSmall = symmetric(vertical: 4.0);
  static EdgeInsets verticalSmall = symmetric(vertical: 8.0);
  static EdgeInsets verticalMedium = symmetric(vertical: 16.0);
  static EdgeInsets verticalLarge = symmetric(vertical: 24.0);
  static EdgeInsets verticalExtraLarge = symmetric(vertical: 32.0);

  // Specific use case padding presets
  static EdgeInsets screenPadding = symmetric(horizontal: 16.0, vertical: 8.0);
  static EdgeInsets cardPadding = all(12.0);
  static EdgeInsets listItemPadding = symmetric(vertical: 12.0);
  static EdgeInsets buttonPadding = symmetric(horizontal: 16.0, vertical: 8.0);

  // Only padding presets
  // Only left
  static EdgeInsets onlyLeftSmall = only(left: 8.0);
  static EdgeInsets onlyLeftMedium = only(left: 16.0);
  static EdgeInsets onlyLeftLarge = only(left: 24.0);
  // Only right
  static EdgeInsets onlyRightSmall = only(right: 8.0);
  static EdgeInsets onlyRightMedium = only(right: 16.0);
  static EdgeInsets onlyRightLarge = only(right: 24.0);
  // Only top
  static EdgeInsets onlyTopExtraSmall = only(top: 4.0);
  static EdgeInsets onlyTopSmall = only(top: 8.0);
  static EdgeInsets onlyTopMedium = only(top: 16.0);
  static EdgeInsets onlyTopLarge = only(top: 24.0);
  // Only bottom
  static EdgeInsets onlyBottomSmall = only(bottom: 8.0);
  static EdgeInsets onlyBottomMedium = only(bottom: 16.0);
  static EdgeInsets onlyBottomLarge = only(bottom: 24.0);

  // Page-specific paddings (to be defined)
  static EdgeInsets floatingActionBottomPaddng =
      only(bottom: _floatingActionBottomPaddingValue);
  static EdgeInsets homePadding = all(homePaddingValue);

  // Custom values for specific cases (to be defined)
  static const double _floatingActionBottomPaddingValue = 70;
  static const double homePaddingValue = 10.0;
}
