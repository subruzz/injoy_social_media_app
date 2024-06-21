import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_padding.dart';
import 'package:social_media_app/core/const/app_sizedbox.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/features/auth/presentation/widgets/auth/auth_choosing_text.dart';
import 'package:social_media_app/features/auth/presentation/widgets/auth/auth_form.dart';
import 'package:social_media_app/features/auth/presentation/widgets/auth/google_auth.dart';
import 'package:social_media_app/features/auth/presentation/widgets/login/forgot_password_text.dart';
import 'package:social_media_app/features/auth/presentation/widgets/login/login_button.dart';
import 'package:social_media_app/features/auth/presentation/widgets/separating_divider.dart';
import 'package:social_media_app/features/auth/presentation/widgets/welcome_msg/welcome_msg.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.authPadding),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: constraints.maxWidth,
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const WelcomeMessage(
                            title1: 'Login to your', title2: 'Account'),
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
                        const AuthChoosingText(
                          islogin: true,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
