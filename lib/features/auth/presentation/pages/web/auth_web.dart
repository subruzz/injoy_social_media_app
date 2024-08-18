import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import '../../../../../core/widgets/web/web_helper_container.dart';
import '../../widgets/auth/auth_choosing_text.dart';

class AuthForWeb extends StatelessWidget {
  const AuthForWeb({super.key, required this.child, this.isLogin = true});
  final Widget child;
  final bool isLogin;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WebHelperContainerWithBorder(child: child),
            AppSizedBox.sizedBox20H,
            WebHelperContainerWithBorder(
              lessPadding: true,
              child: AuthChoosingText(
                islogin: isLogin,
              ),
            )
          ],
        ),
      ),
    );
  }
}


