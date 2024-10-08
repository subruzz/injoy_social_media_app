import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/widgets/messenger/messenger.dart';
import 'package:social_media_app/features/auth/presentation/bloc/forgot_password/forgot_password_bloc.dart';

import '../../../../core/const/app_config/app_sizedbox.dart';
import '../../../../core/utils/di/di.dart';
import '../../../../core/widgets/textfields/custom_textform_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<ForgotPasswordBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Fogot Password',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
            listener: (context, state) {
              if (state is ForgetPasswordSuccessState) {
                Messenger.showSnackBar(
                    message: 'A link has been send to the given email ');
              }
              if (state is ForgetPasswordFailure) {
                Messenger.showSnackBar(
                    message:
                        'Failed to send verification link , please try again later!');
              }
            },
            builder: (context, state) {
              if (state is ForgetPasswordLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/forgot_password.webp',
                        width: 250.w,
                      ),
                    ),
                    const Text(
                        textAlign: TextAlign.center,
                        'Just enter the email address associated with your account, and we\'ll send you a link to reset your password. '),
                    AppSizedBox.sizedBox20H,
                    CustomTextField(
                      showPrefixIcon: true,
                      obsecureText: false,
                      controller: _emailController,

                      keyboardType: TextInputType.emailAddress,
                      hintText: 'Email',
                      showSuffixIcon: false,
                      // validation: (val) {
                      //   if (val!.isEmpty) {
                      //     return "Please fill in this field";
                      //   } else if (!val.validateEmail()) {
                      //     return "Please enter a valid email";
                      //   }
                      //   return null;
                      // },
                    ),
                    AppSizedBox.sizedBox20H,
                    // AuthButton(
                    //     title: 'Reset Password',
                    //     onClick: () {
                    //       context.read<ForgotPasswordBloc>().add(
                    //             ForgotPassWordResetEvent(
                    //                 email: _emailController.text.trim()),
                    //           );
                    //     }),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
