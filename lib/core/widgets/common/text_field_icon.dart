import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/utils/responsive/responsive_helper.dart';
import 'package:social_media_app/core/widgets/common/app_svg.dart';

class TextFieldIcon extends StatelessWidget {
  const TextFieldIcon({super.key, required this.asset});
  final String asset;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Responsive.deskTopAndTab(context) ? 13 : 15.w),
      child: CustomSvgIcon(
        height: 10,
        width: 10,
        assetPath: asset,
      ),
    );
  }
}
