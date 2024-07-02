import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final class AppPadding {
  AppPadding._();

  // General Padding
  static EdgeInsets all(double value) => EdgeInsets.all(value.w);

  static EdgeInsets symmetric(
          {double horizontal = 0.0, double vertical = 0.0}) =>
      EdgeInsets.symmetric(horizontal: horizontal.w, vertical: vertical.w);

  static EdgeInsets only(
          {double left = 0.0,
          double top = 0.0,
          double right = 0.0,
          double bottom = 0.0}) =>
      EdgeInsets.only(
          left: left.w, top: top.w, right: right.w, bottom: bottom.w);

  // Specific Paddings (Commonly Used)
  static EdgeInsets extraSmall = all(4.0);
  static EdgeInsets small = all(8.0);
  static EdgeInsets medium = all(16.0);
  static EdgeInsets large = all(24.0);
  static EdgeInsets extraLarge = all(32.0);

  // Horizontal Paddings
  static EdgeInsets horizontalExtraSmall = symmetric(horizontal: 4.0);
  static EdgeInsets horizontalSmall = symmetric(horizontal: 8.0);
  static EdgeInsets horizontalMedium = symmetric(horizontal: 16.0);
  static EdgeInsets horizontalLarge = symmetric(horizontal: 24.0);
  static EdgeInsets horizontalExtraLarge = symmetric(horizontal: 32.0);

  // Vertical Paddings
  static EdgeInsets verticalExtraSmall = symmetric(vertical: 4.0);
  static EdgeInsets verticalSmall = symmetric(vertical: 8.0);
  static EdgeInsets verticalMedium = symmetric(vertical: 16.0);
  static EdgeInsets verticalLarge = symmetric(vertical: 24.0);
  static EdgeInsets verticalExtraLarge = symmetric(vertical: 32.0);

  // Specific Use Case Paddings
  static EdgeInsets screenPadding = symmetric(horizontal: 16.0, vertical: 8.0);
  static EdgeInsets cardPadding = all(12.0);
  static EdgeInsets listItemPadding = symmetric(vertical: 12.0);
  static EdgeInsets buttonPadding = symmetric(horizontal: 16.0, vertical: 8.0);

  //------------------------- Only Paddings-----------------------------//

  //only left
  static EdgeInsets onlyLeftSmall = only(left: 8.0);
  static EdgeInsets onlyLeftMedium = only(left: 16.0);
  static EdgeInsets onlyLeftLarge = only(left: 24.0);
  //only right
  static EdgeInsets onlyRightSmall = only(right: 8.0);
  static EdgeInsets onlyRightMedium = only(right: 16.0);
  static EdgeInsets onlyRightLarge = only(right: 24.0);
  //only top
  static EdgeInsets onlyTopSmall = only(top: 8.0);
  static EdgeInsets onlyTopMedium = only(top: 16.0);
  static EdgeInsets onlyTopLarge = only(top: 24.0);
  //only bottom
  static EdgeInsets onlyBottomSmall = only(bottom: 8.0);
  static EdgeInsets onlyBottomMedium = only(bottom: 16.0);
  static EdgeInsets onlyBottomLarge = only(bottom: 24.0);

  // Page-Specific Paddings(Todo)
  static EdgeInsets floatingActionBottomPaddng =
      only(bottom: _floatingActionBottomPaddingValue);
  static EdgeInsets homePadding = all(homePaddingValue);

  // Custom values for specific cases(Todo)
  static const double _floatingActionBottomPaddingValue = 70;
  static const double homePaddingValue = 10.0;
}
