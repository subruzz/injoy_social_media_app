import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

class PostSendButton extends StatelessWidget {
  const PostSendButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          width: 25,
          height: 25,
          'assets/svgs/send.svg',
          colorFilter: ColorFilter.mode(
            AppDarkColor().iconSoftColor,
            BlendMode.srcIn,
          ),
        ),
      ],
    );
  }
}
