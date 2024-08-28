import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/theme/widget_themes/text_theme.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/widgets/app_related/common_text.dart';
import 'package:social_media_app/core/widgets/messenger/messenger.dart';
import 'package:social_media_app/core/utils/routes/tranistions/app_routes_const.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/features/auth/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:social_media_app/core/widgets/button/custom_elevated_button.dart';
import 'package:social_media_app/features/bottom_nav/presentation/web/web_layout.dart';

import '../../../../../core/utils/responsive/responsive_helper.dart';
import '../../../../bottom_nav/presentation/pages/bottom_bar_builder.dart';

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
    return CustomButton(
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            Messenger.showSnackBar(
              message: '${state.errorMsg}\n${state.details}',
            );
          }
          if (state is LoginSuccess) {
            if (state.user.fullName != null) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const Responsive(
                    mobile: BottomBarBuilder(),
                    tablet: WebLayout(),
                    desktop: WebLayout()),
              ));
            } else {
              Navigator.pushReplacementNamed(
                context,
                MyAppRouteConst.addProfilePage,
                arguments: state.user,
              );
            }
          }
        },
        builder: (context, state) {
          if (state is LoginLoading) {
            return const CircularLoading();
          }
          return CustomText(
              text: 'Log In',
              style: AppTextTheme.getResponsiveTextTheme(context)
                  .labelMedium
                  ?.copyWith(fontSize: isThatTabOrDeskTop ? 16 : null));
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
