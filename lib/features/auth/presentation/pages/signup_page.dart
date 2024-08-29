import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/widgets/app_related/app_custom_appbar.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/core/widgets/app_related/custom_scrollable_ontent.dart';
import 'package:social_media_app/features/auth/presentation/pages/web/auth_web.dart';
import 'package:social_media_app/features/auth/presentation/widgets/auth/google_auth_builder.dart';
import 'package:social_media_app/features/auth/presentation/widgets/signup/signup_button.dart';
import 'package:social_media_app/core/utils/di/init_dependecies.dart';
import '../../../../core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/features/auth/presentation/widgets/auth/auth_choosing_text.dart';
import 'package:social_media_app/features/auth/presentation/widgets/auth/auth_form.dart';
import 'package:social_media_app/features/auth/presentation/widgets/shared/separating_divider.dart';
import 'package:social_media_app/core/widgets/welcome_msg/welcome_msg.dart';

import '../bloc/signup_bloc/signup_bloc.dart';

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
    var width = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => serviceLocator<SignupBloc>(),
      child: Scaffold(
        appBar: AppCustomAppbar(
          showLeading: true,
        ),
        body: CustomAppPadding(
          child: CustomScrollableContent(
              child: width > 650
                  ? AuthForWeb(
                      isLogin: false,
                      child: _SignupColumn(
                          formKey: _formKey,
                          emailController: _emailController,
                          passWordController: _passwordController))
                  : _SignupColumn(
                      formKey: _formKey,
                      emailController: _emailController,
                      passWordController: _passwordController)),
        ),
      ),
    );
  }
}

class _SignupColumn extends StatelessWidget {
  const _SignupColumn(
      {required this.formKey,
      required this.emailController,
      required this.passWordController});
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passWordController;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const WelcomeMessage(title1: 'Create Your', title2: 'Account'),
        AppSizedBox.sizedBox40H,
        AuthForm(
          formKey: formKey,
          emailController: emailController,
          passwordController: passWordController,
        ),
        AppSizedBox.sizedBox30H,
        SignupButton(
            formKey: formKey,
            emailController: emailController,
            passwordController: passWordController),
        AppSizedBox.sizedBox10H,
        if (isThatMobile) const SeparatingDivider(),
        AppSizedBox.sizedBox10H,
        if (isThatMobile) const GoogleAuthBuilder(),
        if (isThatMobile) const AuthChoosingText()
      ],
    );
  }
}
