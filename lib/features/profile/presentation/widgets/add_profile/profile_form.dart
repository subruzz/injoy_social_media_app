import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/utils/functions/date_picker.dart';
import 'package:social_media_app/core/utils/validations/validations.dart';
import 'package:social_media_app/core/widgets/textfields/custom_textform_field.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile_bloc/index.dart';
import 'package:social_media_app/features/profile/presentation/pages/add_profile/username_check_page.dart';
import 'package:social_media_app/features/profile/presentation/widgets/add_profile/user_profile_img.dart';

import '../../../../../core/widgets/button/custom_elevated_button.dart';

class ProfileForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController phoneNoController;
  final TextEditingController occupationController;
  final TextEditingController aboutController;
  final TextEditingController dobController;
  final ValueNotifier<File?> selectImage;
  final VoidCallback onPress;
  // final TextEditingController locationController;
  const ProfileForm({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.phoneNoController,
    required this.occupationController,
    required this.aboutController,
    required this.onPress,
    required this.dobController,
    required this.selectImage,
  });
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSizedBox.sizedBox40H,
          Center(child: UserProfileImg(userProfile: selectImage)),
          AppSizedBox.sizedBox15H,
          CustomTextField(
            controller: nameController,
            hintText: 'Full Name',
            validation: Validation.simpleValidation,
          ),
          AppSizedBox.sizedBox15H,
          CustomTextField(
            readOnly: true,
            controller: dobController,
            showSuffixIcon: true,
            hintText: 'Date of Birth',
            datePicker: () async {
              final String? dob = await pickDate(context);

              if (dob != null) {
                dobController.text = dob;
              }
            },
            validation: Validation.dateOfBirthValidation,
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
          AppSizedBox.sizedBox25H,
          BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => UsernameCheckPage(
                    userid: context.read<AppUserBloc>().appUser.id),
              ));
            },
            child: CustomButton(
              onClick: onPress,
              child: const Text('Next'),
            ),
          ),
        ],
      ),
    );
  }
}
