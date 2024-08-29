
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_media_app/core/utils/routes/tranistions/app_routes_const.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile/user_profile_bloc/profile_bloc.dart';
import 'package:social_media_app/features/profile/presentation/widgets/next_button.dart';
import 'package:social_media_app/features/profile/presentation/widgets/next_icon.dart';

import '../../bloc/user_profile/user_profile_bloc/profile_state.dart';

class AddProfileButton extends StatefulWidget {
  const AddProfileButton(
      {super.key, required this.onPressed, required this.isValid});
  final void Function() onPressed;
  final bool isValid;
  @override
  State<AddProfileButton> createState() => _AddProfileButtonState();
}

class _AddProfileButtonState extends State<AddProfileButton> {
  late bool isValid;
  @override
  void initState() {
    isValid = widget.isValid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listenWhen: (previous, current) =>
          current is ProfileSetUpLoading || current is ProfileSetupSuccess,
      listener: (context, state) {
        if (state is ProfileSetupSuccess) {
          Navigator.pushNamed(context, MyAppRouteConst.interestSelectRoute);
        }
      },
      child: NextButton(
        onpressed: widget.onPressed,
        child: const NextIcon(),
      ),
    );
  }
}
