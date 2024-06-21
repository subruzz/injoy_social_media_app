import 'package:flutter/material.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/features/auth/presentation/pages/login_page.dart';
import 'package:social_media_app/features/auth/presentation/pages/signup_page.dart';

class AuthChoosingText extends StatelessWidget {
  const AuthChoosingText({super.key, this.islogin = false});
  final bool islogin;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              islogin ? 'Don\'t have an Account?' : 'Already have an account?',
            ),
            TextButton(
              onPressed: () {
                islogin
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const SignupPage();
                          },
                        ),
                      )
                    : Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const LoginPage();
                          },
                        ),
                      );
              },
              child: Text(
                islogin ? 'Sign Up' : ' Log In',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppDarkColor().secondaryPrimaryText),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
