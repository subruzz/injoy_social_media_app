import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_sizedbox.dart';
import 'package:social_media_app/core/extensions/email_val.dart';
import 'package:social_media_app/core/widgets/textfields/text_field.dart';

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
            showPrefixIcon: true,
            obsecureText: false,
            controller: emailController,
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            hintText: 'Email',
            showSuffixIcon: false,
            validation: (val) {
              if (val!.isEmpty) {
                return "Please fill in this field";
              } else if (!val.validateEmail()) {
                return "Please enter a valid email";
              }
              return null;
            },
          ),
          AppSizedBox.sizedBox15H,
          CustomTextField(
            showPrefixIcon: true,
            showSuffixIcon: true,
            controller: passwordController,
            prefixIcon: Icons.password,
            obsecureText: true,
            hintText: 'Password',
            validation: (val) {
              if (val!.isEmpty) {
                return "Please fill in this Field.";
              } else if (val.length < 3) {
                return "Password should be at least 6 characters long.";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
