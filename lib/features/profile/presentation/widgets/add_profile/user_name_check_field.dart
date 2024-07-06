import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/utils/validations/validations.dart';
import 'package:social_media_app/core/widgets/textfields/custom_textform_field.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile_bloc/profile_bloc.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile_bloc/profile_event.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile_bloc/profile_state.dart';

class UserNameCheckField extends StatelessWidget {
  const UserNameCheckField({super.key, required this.userNameController});
  final TextEditingController userNameController;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (previous, current) =>
          current is UserNamecheckingLoading ||
          current is UserNameCheckError ||
          current is UserNameAvailabelState ||
          current is UserNameNotAvailabelState,
      builder: (context, state) {
        final bool isChecking = state is UserNamecheckingLoading;
        final bool isAvailable = state is UserNameAvailabelState;
        final bool isTaken = state is UserNameNotAvailabelState;
        return CustomTextField(
            onChanged: (value) {
              context
                  .read<ProfileBloc>()
                  .add(UserNameExistCheckEvent(userName: value));
            },
            showPrefixIcon: true,
            controller: userNameController,
            hintText: 'Username',
            errorColor: isAvailable ? Colors.green : null,
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
