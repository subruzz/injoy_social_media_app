import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/shared_providers/cubits/pick_single_image/pick_image_cubit.dart';
import 'package:social_media_app/core/utils/debouncer.dart';
import 'package:social_media_app/core/utils/functions/date_picker.dart';
import 'package:social_media_app/core/utils/validations/validations.dart';
import 'package:social_media_app/core/widgets/textfields/custom_textform_field.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile_bloc/profile_event.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile_bloc/profile_state.dart';
import 'package:social_media_app/features/profile/presentation/widgets/add_profile/user_name_check_field.dart';
import 'package:social_media_app/features/profile/presentation/widgets/add_profile/user_profile_pic.dart';

import '../../bloc/user_profile_bloc/profile_bloc.dart';

class ProfileForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController userNameController;
  final TextEditingController phoneNoController;
  final TextEditingController occupationController;
  final TextEditingController aboutController;
  final TextEditingController dobController;
  final PickSingleImageCubit selectImageCubit;
  final Debouncer debouncer;
  // final TextEditingController locationController;
  const ProfileForm({
    super.key,
    required this.formKey,
    required this.debouncer,
    required this.nameController,
    required this.userNameController,
    required this.phoneNoController,
    required this.occupationController,
    required this.aboutController,
    required this.dobController,
    required this.selectImageCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSizedBox.sizedBox40H,
          UserProfilePicSelect(selectImageCuit: selectImageCubit),
          AppSizedBox.sizedBox15H,
          CustomTextField(
            controller: nameController,
            hintText: 'Full Name',
            validation: Validation.simpleValidation,
          ),
          AppSizedBox.sizedBox20H,
          UserNameCheckField(userNameController: userNameController,debouncer: debouncer,),
          AppSizedBox.sizedBox15H,
          BlocListener<ProfileBloc, ProfileState>(
            listenWhen: (previous, current) => current is DateOfBirthSet,
            listener: (context, state) {
              if (state is DateOfBirthSet) {
                dobController.text = state.dateOfBirth;
              }
            },
            child: CustomTextField(
              readOnly: true,
              controller: dobController,
              showSuffixIcon: true,
              hintText: 'Date of Birth',
              datePicker: () {
                context.read<ProfileBloc>().add(
                  DateOfBirthSelected(
                    onDateSelected: () async {
                      return await pickDate(context);
                    },
                  ),
                );
              },
              validation: Validation.simpleValidation,
            ),
          ),
       
          AppSizedBox.sizedBox15H,
          CustomTextField(
            controller: phoneNoController,
            hintText: 'Phone Number',
            validation: Validation.phoneNoValidation,
          ),
          AppSizedBox.sizedBox15H,
          CustomTextField(
            controller: occupationController,
            hintText: 'Occupation',
          ),
          AppSizedBox.sizedBox15H,
          CustomTextField(
            controller: aboutController,
            hintText: 'About',
            maxLine: 3,
          ),
          AppSizedBox.sizedBox15H,
        ],
      ),
    );
  }
}
