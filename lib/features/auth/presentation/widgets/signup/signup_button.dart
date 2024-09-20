import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/theme/widget_themes/text_theme.dart';
import 'package:social_media_app/core/widgets/common/common_text.dart';
import 'package:social_media_app/core/widgets/messenger/messenger.dart';
import 'package:social_media_app/core/utils/routes/tranistions/app_routes_const.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/features/auth/presentation/bloc/signup_bloc/signup_bloc.dart';
import 'package:social_media_app/core/widgets/button/custom_elevated_button.dart';

import '../../../../../core/utils/responsive/constants.dart';
import '../../../../../core/widgets/loading/circular_loading.dart';

class SignupButton extends StatelessWidget {
  const SignupButton({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      child: BlocConsumer<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is SignupFailure) {
            Messenger.showSnackBar(
              message: '${state.errorMsg}\n${state.details}',
            );
          }
          if (state is SignupSuccess) {
            Navigator.pushReplacementNamed(
              context,
              MyAppRouteConst.addProfilePage,
              arguments: state.user,
            );
          }
        },
        builder: (context, state) {
          if (state is SignupLoading) {
            return const CircularLoading();
          }
          return CustomText(
              text: 'Sign Up',
              style:AppTextTheme.getResponsiveTextTheme(context).labelMedium
                  ?.copyWith(fontSize: isThatTabOrDeskTop ? 16 : null));
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
