import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_app/core/routes/app_routes_const.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile_bloc/profile_bloc.dart';
import 'package:social_media_app/features/profile/presentation/widgets/next_button.dart';
import 'package:social_media_app/features/profile/presentation/widgets/next_icon.dart';

import '../../bloc/user_profile_bloc/profile_state.dart';

class AddProfileButton extends StatelessWidget {
  const AddProfileButton({super.key, required this.onPressed});
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listenWhen: (previous, current) =>
          current is ProfileSetUpLoading ||
          current is ProfileSetupSuccess,
      listener: (context, state) {
        if (state is ProfileSetupSuccess) {
          context.pushNamed(MyAppRouteConst.interestSelectRoute);
        }
      },
      child: NextButton(
        onpressed: onPressed,
        child: const NextIcon(),
      ),
    );
  }
}
