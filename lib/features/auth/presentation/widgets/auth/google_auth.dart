import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_app/core/widgets/app_related/common_text.dart';
import 'package:social_media_app/core/const/app_msg/app_ui_string_const.dart';
import 'package:social_media_app/core/const/messenger.dart';
import 'package:social_media_app/core/routes/app_routes_const.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/features/auth/presentation/bloc/google_auth/google_auth_bloc.dart';
import 'package:social_media_app/core/widgets/button/custom_elevated_button.dart';

class GoogleAuthButton extends StatelessWidget {
  const GoogleAuthButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GoogleAuthBloc, GoogleAuthState>(
      listener: (context, state) {
        if (state is GoogleAuthSuccess) {
          state.user.fullName == null
              ? context.pushReplacementNamed(MyAppRouteConst.addProfilePage,
                  extra: state.user)
              : context.pushReplacementNamed(MyAppRouteConst.bottomNavRoute);
        }
        if (state is GoogleAuthFailure) {
          Messenger.showSnackBar(message: state.errorMsg);
        }
      },
      builder: (context, state) {
        if (state is GoogleAuthLoading) {
          return const CircularLoading();
        }
        return CustomButton(
          isShowIcon: true,
          color: AppDarkColor().buttonWhitishBackground,
          child: CustomText(
            AppUiStringConst.googleLogin,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold, color: AppDarkColor().background),
          ),
          onClick: () {
            context.read<GoogleAuthBloc>().add(GoogleAuthStartEvent());
          },
        );
      },
    );
  }
}
