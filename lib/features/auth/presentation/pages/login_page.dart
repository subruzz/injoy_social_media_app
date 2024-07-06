import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/app_msg/app_ui_string_const.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/core/widgets/app_related/custom_scrollable_ontent.dart';
import 'package:social_media_app/features/auth/presentation/widgets/auth/auth_choosing_text.dart';
import 'package:social_media_app/features/auth/presentation/widgets/auth/auth_form.dart';
import 'package:social_media_app/features/auth/presentation/widgets/auth/google_auth.dart';
import 'package:social_media_app/features/auth/presentation/widgets/login/forgot_password_text.dart';
import 'package:social_media_app/features/auth/presentation/widgets/login/login_button.dart';
import 'package:social_media_app/features/auth/presentation/widgets/shared/separating_divider.dart';
import 'package:social_media_app/core/widgets/welcome_msg/welcome_msg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomAppPadding(
          child: CustomScrollableContent(
            child: Hero(
              tag: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppSizedBox.sizedBox40H,
                  const WelcomeMessage(
                      title1: AppUiStringConst.loginWelcome,
                      title2: AppUiStringConst.account),
                  AppSizedBox.sizedBox40H,
                  AuthForm(
                    formKey: _formKey,
                    emailController: _emailController,
                    passwordController: _passwordController,
                  ),
                  AppSizedBox.sizedBox10H,
                  const ForgotPasswordText(),
                  LoginButton(
                      formKey: _formKey,
                      emailController: _emailController,
                      passwordController: _passwordController),
                  AppSizedBox.sizedBox10H,
                  const SeparatingDivider(),
                  AppSizedBox.sizedBox10H,
                  const GoogleAuthButton(),
                  AppSizedBox.sizedBox5H,
                  const AuthChoosingText(
                    islogin: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
