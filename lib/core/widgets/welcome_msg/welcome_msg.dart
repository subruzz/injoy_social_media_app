import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:social_media_app/core/const/app_sizedbox.dart';
import 'package:social_media_app/core/widgets/welcome_msg/welcom_text.dart';

class WelcomeMessage extends StatelessWidget {
  const WelcomeMessage({
    super.key,
    required this.title1,
    required this.title2,
  });
  final String title1;
  final String title2;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WelcomeTitle(text: title1),
          AppSizedBox.sizedBox10H,
          WelcomeTitle(text: title2)
        ],
      ),
    );
  }
}
