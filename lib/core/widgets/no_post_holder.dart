import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/widgets/common/common_text.dart';

class NoPostHolder extends StatelessWidget {
  const NoPostHolder({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: CustomText(
          text: text,
        ),
      ),
    );
  }
}
