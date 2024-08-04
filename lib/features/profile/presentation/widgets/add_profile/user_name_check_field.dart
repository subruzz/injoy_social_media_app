import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/utils/debouncer.dart';
import 'package:social_media_app/core/utils/validations/validations.dart';
import 'package:social_media_app/core/widgets/textfields/custom_textform_field.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_name_cubit/user_name_cubit.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile_bloc/profile_bloc.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile_bloc/profile_event.dart';

class UserNameCheckField extends StatelessWidget {
  const UserNameCheckField(
      {super.key,
      required this.userNameController,
      required this.debouncer,
      required this.userNameCubit});
  final TextEditingController userNameController;
  final Debouncer debouncer;
  final UserNameCubit userNameCubit;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: userNameCubit,
      builder: (context, state) {
        // final bool isEmpty = state is UserNameCheckInitial;
        final bool isChecking = state is UserNamecheckingLoading;
        final bool isAvailable = state is UserNameAvailableState;
        final bool isTaken = state is UserNameNotAvailableState;
        return CustomTextField(
            onChanged: (value) {
              debouncer.run(() {
                userNameCubit.userNameCheck(value);
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
