import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/messenger.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/features/auth/presentation/bloc/signup_bloc/signup_bloc.dart';
import 'package:social_media_app/features/auth/presentation/widgets/auth/auth_button.dart';
import 'package:social_media_app/features/auth/presentation/widgets/auth/auth_button_text.dart';
import 'package:social_media_app/features/profile/presentation/pages/add_profile_page.dart';

import '../../../../../core/widgets/loading/circular_loading.dart';

class SignupButton extends StatelessWidget {
  const SignupButton(
      {super.key,
      required this.formKey,
      required this.emailController,
      required this.passwordController});
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  @override
  Widget build(BuildContext context) {
    return AuthButton(
      child: BlocConsumer<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is SignupFailure) {
            Messenger.showSnackBar(
                message: '${state.errorMsg}\n${state.details}',
                color: AppDarkColor().buttonBackground);
          }
          if (state is SignupSuccess) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => AddProfilePage(
                  appUser: state.user,
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is SignupLoading) {
            return const CircularLoading();
          }
          return const AuthButtonText(title: 'Sign Up');
        },
      ),
      onClick: () {
        if (formKey.currentState!.validate()) {
          context.read<SignupBloc>().add(
                SignupUserEvent(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                ),
              );
        }
      },
    );
  }
}
