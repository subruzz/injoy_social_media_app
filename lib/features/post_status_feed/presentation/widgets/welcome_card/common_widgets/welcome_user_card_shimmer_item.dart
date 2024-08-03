import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class ShimmerUserCard extends StatelessWidget {
  const ShimmerUserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppDarkColor().secondaryBackground,
      highlightColor: AppDarkColor().softBackground,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: .8.sw,
          margin: EdgeInsets.symmetric(vertical: 20.h),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 60.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Profile Picture Placeholder
                Container(
                  height: 50.h,
                  width: 50.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade700,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(height: 10.h),
                // Username Placeholder
                Container(
                  height: 16.h,
                  width: 80.w,
                  color: Colors.grey.shade700,
                ),
                SizedBox(height: 8.h),
                // Full Name Placeholder
                Container(
                  height: 14.h,
                  width: 120.w,
                  color: Colors.grey.shade700,
                ),
                SizedBox(height: 30.h),
                // Follow Button Placeholder
                Container(
                  height: 40.h,
                  width: 0.4.sw,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade700,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
