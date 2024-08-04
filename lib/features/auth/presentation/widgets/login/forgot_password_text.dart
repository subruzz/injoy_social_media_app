import 'package:flutter/material.dart';
import 'package:social_media_app/core/widgets/app_related/common_text.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

import '../../pages/forgot_password_page.dart';

class ForgotPasswordText extends StatelessWidget {
  const ForgotPasswordText({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ForgotPasswordPage(),
              ),
            );
          },
          child: Text(
            'Forgot Password?',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppDarkColor().secondaryPrimaryText),
          )),
    );
  }
}
