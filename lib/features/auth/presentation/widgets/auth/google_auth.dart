import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/messenger.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/features/auth/presentation/bloc/google_auth/google_auth_bloc.dart';
import 'package:social_media_app/features/auth/presentation/widgets/auth/auth_button.dart';
import 'package:social_media_app/features/bottom_nav/presentation/pages/bottom_nav.dart';
import 'package:social_media_app/features/profile/presentation/pages/add_profile_page.dart';

class GoogleAuthButton extends StatelessWidget {
  const GoogleAuthButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GoogleAuthBloc, GoogleAuthState>(
      listener: (context, state) {
        if (state is GoogleAuthSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return state.user.fullName == null
                  ? AddProfilePage(
                      appUser: state.user,
                    )
                  : const BottonNavWithAnimatedIcons();
            }),
          );
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
          child: Text(
            'Continue with google',
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
