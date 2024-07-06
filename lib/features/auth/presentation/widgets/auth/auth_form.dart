import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/utils/validations/validations.dart';
import 'package:social_media_app/core/widgets/textfields/custom_textform_field.dart';

class AuthForm extends StatelessWidget {
  const AuthForm(
      {super.key,
      required this.formKey,
      required this.emailController,
      required this.passwordController});
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
              controller: emailController,
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              hintText: 'Email',
              validation: Validation.validateEmail),
          AppSizedBox.sizedBox15H,
          CustomTextField(
              showSuffixIcon: true,
              controller: passwordController,
              prefixIcon: Icons.password,
              obsecureText: true,
              hintText: 'Password',
              validation: Validation.validatePassword),
        ],
      ),
    );
  }
}
