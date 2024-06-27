import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/messenger.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:social_media_app/features/auth/presentation/widgets/auth/auth_button.dart';
import 'package:social_media_app/features/auth/presentation/widgets/auth/auth_button_text.dart';
import 'package:social_media_app/features/bottom_nav/presentation/pages/bottom_nav.dart';
import 'package:social_media_app/features/profile/presentation/pages/add_profile_page.dart';

class LoginButton extends StatelessWidget {
  const LoginButton(
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
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            Messenger.showSnackBar(
                message: '${state.errorMsg}\n${state.details}',
               );
          }
          if (state is LoginSuccess) {
            if (state.user.fullName!=null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BottonNavWithAnimatedIcons(),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddProfilePage(
                    appUser: state.user,
                  ),
                ),
              );
            }
          }
        },
        builder: (context, state) {
          if (state is LoginLoading) {
            return const CircularLoading();
          }
          return const AuthButtonText(title: 'Login');
        },
      ),
      onClick: () {
        if (formKey.currentState!.validate()) {
          context.read<LoginBloc>().add(
                LoginUserEvent(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                ),
              );
        }
      },
    );
  }
}
