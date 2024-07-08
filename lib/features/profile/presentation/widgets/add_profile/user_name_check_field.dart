import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/utils/debouncer.dart';
import 'package:social_media_app/core/utils/validations/validations.dart';
import 'package:social_media_app/core/widgets/textfields/custom_textform_field.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile_bloc/profile_bloc.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile_bloc/profile_event.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile_bloc/profile_state.dart';

class UserNameCheckField extends StatelessWidget {
  const UserNameCheckField(
      {super.key, required this.userNameController, required this.debouncer});
  final TextEditingController userNameController;
  final Debouncer debouncer;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) =>
          current is UserNamecheckingLoading ||
          current is UserNameCheckError ||
          current is UserNameAvailabelState ||
          current is UserNameNotAvailabelState||
          current is UserNameCheckInitial,
      builder: (context, state) {
        // final bool isEmpty = state is UserNameCheckInitial;
        final bool isChecking = state is UserNamecheckingLoading;
        final bool isAvailable = state is UserNameAvailabelState;
        final bool isTaken = state is UserNameNotAvailabelState;
        return CustomTextField(
            onChanged: (value) {
              debouncer.run(() {
                context
                    .read<ProfileBloc>()
                    .add(UserNameExistCheckEvent(userName: value));
              });
            },
            showPrefixIcon: true,
            controller: userNameController,
            hintText: 'Username',
            errorColor: isAvailable
                ? Colors.green
                : AppDarkColor().secondaryPrimaryText,
            errorMsg: isChecking
                ? '🔄 Checking username...'
                : isAvailable
                    ? '✅ Username is available'
                    : isTaken
                        ? '❌ Username is already taken'
                        : null,
            validation: Validation.simpleValidation);
      },
    );
  }
}
