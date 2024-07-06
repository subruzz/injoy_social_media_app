import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_app/core/const/app_msg/app_ui_string_const.dart';
import 'package:social_media_app/core/routes/app_routes_const.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';

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
            Text(islogin
                ? AppUiStringConst.dontHaveAccount
                : AppUiStringConst.haveAccount),
            TextButton(
              onPressed: () {
                islogin
                    ? context.pushNamed(MyAppRouteConst.signUpRoute)
                    : context.goNamed(MyAppRouteConst.loginRoute);
              },
              child: Text(
                islogin ? AppUiStringConst.signUp : AppUiStringConst.login,
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
