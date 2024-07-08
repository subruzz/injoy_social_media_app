import 'package:flutter/material.dart';
import 'package:social_media_app/core/widgets/app_related/app_custom_appbar.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/core/widgets/app_related/custom_scrollable_ontent.dart';
import 'package:social_media_app/features/auth/presentation/widgets/signup/signup_button.dart';
import '../../../../core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/features/auth/presentation/widgets/auth/auth_choosing_text.dart';
import 'package:social_media_app/features/auth/presentation/widgets/auth/auth_form.dart';
import 'package:social_media_app/features/auth/presentation/widgets/auth/google_auth.dart';
import 'package:social_media_app/features/auth/presentation/widgets/shared/separating_divider.dart';
import 'package:social_media_app/core/widgets/welcome_msg/welcome_msg.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
      appBar: AppCustomAppbar(
        leadingIcon: Icons.arrow_back_ios_new_rounded,
        leadingOnPressed: () => Navigator.pop(context),
      ),
      body: CustomAppPadding(
        child: CustomScrollableContent(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const WelcomeMessage(title1: 'Create Your', title2: 'Account'),
              AppSizedBox.sizedBox40H,
              AuthForm(
                formKey: _formKey,
                emailController: _emailController,
                passwordController: _passwordController,
              ),
              AppSizedBox.sizedBox30H,
              SignupButton(
                  formKey: _formKey,
                  emailController: _emailController,
                  passwordController: _passwordController),
              AppSizedBox.sizedBox10H,
              const SeparatingDivider(),
              AppSizedBox.sizedBox10H,
              const GoogleAuthButton(),
              const AuthChoosingText()
            ],
          ),
        ),
      ),
    );
  }
}
