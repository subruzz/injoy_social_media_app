import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final class AppBorderRadius {
  AppBorderRadius._();

  // General BorderRadius
  static BorderRadius all(double value) => BorderRadius.all(Radius.circular(value.w));

  static BorderRadius horizontal({double left = 0.0, double right = 0.0}) =>
      BorderRadius.horizontal(
          left: Radius.circular(left.w), right: Radius.circular(right.w));

  static BorderRadius vertical({double top = 0.0, double bottom = 0.0}) =>
      BorderRadius.vertical(
          top: Radius.circular(top.w), bottom: Radius.circular(bottom.w));

  static BorderRadius only({
    double topLeft = 0.0,
    double topRight = 0.0,
    double bottomLeft = 0.0,
    double bottomRight = 0.0,
  }) =>
      BorderRadius.only(
        topLeft: Radius.circular(topLeft.w),
        topRight: Radius.circular(topRight.w),
        bottomLeft: Radius.circular(bottomLeft.w),
        bottomRight: Radius.circular(bottomRight.w),
      );

  // Specific BorderRadius (Commonly Used)
  static BorderRadius extraSmall = all(4.0);
  static BorderRadius small = all(8.0);
  static BorderRadius medium = all(16.0);
  static BorderRadius large = all(24.0);
  static BorderRadius extraLarge = all(32.0);

  // Horizontal BorderRadius
  static BorderRadius horizontalExtraSmall = horizontal(left: 4.0, right: 4.0);
  static BorderRadius horizontalSmall = horizontal(left: 8.0, right: 8.0);
  static BorderRadius horizontalMedium = horizontal(left: 16.0, right: 16.0);
  static BorderRadius horizontalLarge = horizontal(left: 24.0, right: 24.0);
  static BorderRadius horizontalExtraLarge = horizontal(left: 32.0, right: 32.0);

  // Vertical BorderRadius
  static BorderRadius verticalExtraSmall = vertical(top: 4.0, bottom: 4.0);
  static BorderRadius verticalSmall = vertical(top: 8.0, bottom: 8.0);
  static BorderRadius verticalMedium = vertical(top: 16.0, bottom: 16.0);
  static BorderRadius verticalLarge = vertical(top: 24.0, bottom: 24.0);
  static BorderRadius verticalExtraLarge = vertical(top: 32.0, bottom: 32.0);

  // Specific Use Case BorderRadius
  static BorderRadius cardRadius = all(12.0);
  static BorderRadius buttonRadius = all(8.0);
  static BorderRadius dialogRadius = all(16.0);
  static BorderRadius chipRadius = all(20.0);

  // Page-Specific BorderRadius
  static BorderRadius bottomSheetRadius = only(topLeft: 16.0, topRight: 16.0);
  static BorderRadius dialogTopRadius = only(topLeft: 12.0, topRight: 12.0);

  // Custom values for specific cases
  static const double floatingActionRadiusValue = 28.0;
  static const double homeCardRadiusValue = 10.0;

  // Additional Specific Radius Values
  static double getRadius(double value) => value.w;


  // Complex Radius Cases (with two corners)
  static double topLeftBottomRight(double topLeft, double bottomRight) =>
      topLeft.w;

  static double topRightBottomLeft(double topRight, double bottomLeft) =>
      topRight.w;
}
