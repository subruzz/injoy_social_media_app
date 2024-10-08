import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/theme/widget_themes/text_theme.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/widgets/common/common_text.dart';
import 'package:social_media_app/core/const/app_msg/app_ui_string_const.dart';
import 'package:social_media_app/core/widgets/messenger/messenger.dart';
import 'package:social_media_app/core/utils/routes/tranistions/app_routes_const.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/features/auth/presentation/bloc/google_auth/google_auth_bloc.dart';
import 'package:social_media_app/core/widgets/button/custom_elevated_button.dart';

import '../../../../../core/const/assets/app_assets.dart';

class GoogleAuthButton extends StatelessWidget {
  const GoogleAuthButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GoogleAuthBloc, GoogleAuthState>(
      listener: (context, state) {
        if (state is GoogleAuthSuccess) {
          if (state.user.fullName == null) {
            Navigator.pushReplacementNamed(
              context,
              MyAppRouteConst.addProfilePage,
              arguments: state.user,
            );
          } else {
            Navigator.pushReplacementNamed(
              context,
              MyAppRouteConst.bottomNavRoute,
            );
          }
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
          buttonIcon: Image.asset(
            AppAssetsConst.googleLogo,
            height: 25.h,
          ),
          color: AppDarkColor().buttonWhitishBackground,
          child: CustomText(
              text: AppUiStringConst.googleLogin,
              style: AppTextTheme.getResponsiveTextTheme(context)
                  .labelLarge
                  ?.copyWith(color: AppDarkColor().background)),
          onClick: () {
            context.read<GoogleAuthBloc>().add(GoogleAuthStartEvent());
          },
        );
      },
    );
  }
}
