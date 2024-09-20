import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/const/app_config/app_border_radius.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/widgets/common/app_custom_appbar.dart';
import 'package:social_media_app/core/widgets/button/custom_elevated_button.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/features/auth/presentation/widgets/login/forgot_password_text.dart';
import 'package:social_media_app/features/settings/presentation/cubit/settings/settings_cubit.dart';

import '../../../../core/const/app_config/app_sizedbox.dart';
import '../../../../core/widgets/common/text_field_icon.dart';
import '../../../../core/utils/validations/validations.dart';
import '../../../../core/widgets/textfields/custom_textform_field.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _oldPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _newPassword = TextEditingController();
  @override
  void dispose() {
    _newPassword.dispose();
    _oldPassword.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomAppbar(
        title: 'Reset Password',
        showLeading: true,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocConsumer<SettingsCubit, SettingsState>(
          listenWhen: (previous, current) =>
              current is ChangePasswordLoading ||
              current is ChangePasswordError ||
              current is ChangeEmailSuccess,
          buildWhen: (previous, current) =>
              current is ChangePasswordLoading ||
              current is ChangePasswordError ||
              current is ChangeEmailSuccess,
          listener: (context, state) {},
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/reset_pass.png',
                        width: 250.w,
                      ),
                    ),
                    const Text(
                      'To reset your password, please enter your current password followed by your new password.',
                      textAlign: TextAlign.center,
                    ),
                    AppSizedBox.sizedBox15H,
                    CustomTextField(
                        showSuffixIcon: true,
                        controller: _oldPassword,
                        prefixIcon:
                            const TextFieldIcon(asset: AppAssetsConst.lock),
                        obsecureText: true,
                        hintText: 'Password',
                        validation: Validation.validatePassword),
                    const ForgotPasswordText(),
                    CustomTextField(
                        showSuffixIcon: true,
                        controller: _newPassword,
                        prefixIcon:
                            const TextFieldIcon(asset: AppAssetsConst.lock),
                        obsecureText: true,
                        hintText: 'Password',
                        validation: Validation.validatePassword),
                    AppSizedBox.sizedBox15H,
                    CustomButton(
                        radius: AppBorderRadius.small,
                        onClick: () {
                          if (state is ChangePasswordLoading) return;
                        },
                        child: state is ChangePasswordLoading
                            ? const CircularLoading()
                            : const Text('Reset Password'))
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
