import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_media_app/core/const/app_padding.dart';
import 'package:social_media_app/core/const/app_sizedbox.dart';
import 'package:social_media_app/core/const/messenger.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/features/auth/presentation/bloc/google_auth/google_auth_bloc.dart';
import 'package:social_media_app/features/auth/presentation/bloc/signup_bloc/signup_bloc.dart';
import 'package:social_media_app/features/auth/presentation/pages/login_page.dart';
import 'package:social_media_app/features/auth/presentation/widgets/auth_button.dart';
import 'package:social_media_app/features/auth/presentation/widgets/auth_form.dart';
import 'package:social_media_app/features/auth/presentation/widgets/separating_divider.dart';
import 'package:social_media_app/features/auth/presentation/widgets/welcome_msg/welcome_msg.dart';
import 'package:social_media_app/features/profile/presentation/pages/add_profile_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.authPadding),
          child: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                  minHeight: constraints.maxHeight,
                ),
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
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return IntrinsicHeight(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const WelcomeMessage(
                              title1: 'Create Your', title2: 'Account'),
                          AppSizedBox.sizedBox40H,
                          AuthForm(
                            formKey: _formKey,
                            emailController: _emailController,
                            passwordController: _passwordController,
                          ),
                          AppSizedBox.sizedBox10H,
                          AppSizedBox.sizedBox20H,
                          AuthButton(
                            title: 'Sign Up',
                            onClick: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<SignupBloc>().add(
                                      SignupUserEvent(
                                        email: _emailController.text.trim(),
                                        password:
                                            _passwordController.text.trim(),
                                      ),
                                    );
                              }
                            },
                          ),
                          AppSizedBox.sizedBox10H,
                          const SeparatingDivider(),
                          AppSizedBox.sizedBox10H,
                          BlocConsumer<GoogleAuthBloc, GoogleAuthState>(
                            listener: (context, state) {
                              if (state is GoogleAuthSuccess) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddProfilePage(
                                        appUser: state.user,
                                      ),
                                    ));
                              }
                              if (state is GoogleAuthFailure) {
                                Messenger.showSnackBar(message: state.details);
                              }
                            },
                            builder: (context, state) {
                              if (state is GoogleAuthLoading) {
                                return const CircularProgressIndicator();
                              }
                              return AuthButton(
                                isGoogleAuth: true,
                                title: 'Continue with google',
                                onClick: () {
                                  context
                                      .read<GoogleAuthBloc>()
                                      .add(GoogleAuthStartEvent());
                                },
                              );
                            },
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Already have an account?',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      ' Log In',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              color: AppDarkColor()
                                                  .secondaryPrimaryText),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
