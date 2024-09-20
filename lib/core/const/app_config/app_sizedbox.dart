import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A utility class for creating reusable `SizedBox` widgets 
/// with responsive height and width, using the `FlutterScreenUtil` 
/// package for scaling.
///
/// This class provides static getter methods for commonly used 
/// `SizedBox` dimensions, allowing for consistent spacing in the app.
class AppSizedBox {
  // Private constructor to prevent direct instantiation
  AppSizedBox._();

  // Height SizedBoxes
  static SizedBox get sizedBox3H => SizedBox(height: 3.h);
  static SizedBox get sizedBox5H => SizedBox(height: 5.h);
  static SizedBox get sizedBox10H => SizedBox(height: 10.h);
  static SizedBox get sizedBox15H => SizedBox(height: 15.h);
  static SizedBox get sizedBox20H => SizedBox(height: 20.h);
  static SizedBox get sizedBox25H => SizedBox(height: 25.h);
  static SizedBox get sizedBox30H => SizedBox(height: 30.h);
  static SizedBox get sizedBox35H => SizedBox(height: 35.h);
  static SizedBox get sizedBox40H => SizedBox(height: 40.h);
  static SizedBox get sizedBox45H => SizedBox(height: 45.h);
  static SizedBox get sizedBox50H => SizedBox(height: 50.h);

  // Width SizedBoxes
  static SizedBox get sizedBox5W => SizedBox(width: 5.w);
  static SizedBox get sizedBox10W => SizedBox(width: 10.w);
  static SizedBox get sizedBox15W => SizedBox(width: 15.w);
  static SizedBox get sizedBox20W => SizedBox(width: 20.w);
  static SizedBox get sizedBox25W => SizedBox(width: 25.w);
  static SizedBox get sizedBox30W => SizedBox(width: 30.w);
  static SizedBox get sizedBox35W => SizedBox(width: 35.w);
  static SizedBox get sizedBox40W => SizedBox(width: 40.w);
  static SizedBox get sizedBox45W => SizedBox(width: 45.w);
  static SizedBox get sizedBox50W => SizedBox(width: 50.w);
}
