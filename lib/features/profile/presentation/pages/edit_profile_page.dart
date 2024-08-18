import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/utils/validations/validations.dart';
import 'package:social_media_app/core/widgets/app_related/app_custom_appbar.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/core/widgets/button/custom_elevated_button.dart';
import 'package:social_media_app/core/widgets/loading/loading_bar.dart';
import 'package:social_media_app/core/widgets/textfields/custom_textform_field.dart';
import 'package:social_media_app/core/widgets/common/user_profile.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile/user_profile_bloc/profile_bloc.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile/user_profile_bloc/profile_event.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile/user_profile_bloc/profile_state.dart';
import 'package:social_media_app/features/profile/presentation/widgets/add_profile/edit_profile.dart';
import 'package:social_media_app/features/profile/presentation/widgets/add_profile/user_profile_img.dart';

import '../../../../core/services/assets/asset_services.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({
    super.key,
  });

  @override
  State<EditProfilePage> createState() => _AddProfilePageState();
}

class _AddProfilePageState extends State<EditProfilePage> {
  final _nameController = TextEditingController();
  final _phoneNoController = TextEditingController();
  final _occupationController = TextEditingController();
  final _aboutController = TextEditingController();
  String? _profileImage;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<File?> _userProfile = ValueNotifier(null);
  late AppUser appUser;
  @override
  void initState() {
    super.initState();
    appUser = context.read<AppUserBloc>().appUser;
    _profileImage = appUser.profilePic;
    _nameController.text = appUser.fullName ?? '';
    _phoneNoController.text = appUser.phoneNumber ?? '';
    _occupationController.text = appUser.occupation ?? '';
    _aboutController.text = appUser.about ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomAppbar(
        title: 'Edit Your Profile',
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is CompleteProfileSetupSuceess) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is CompleteProfileSetupLoading) {
            return const LoadingBar();
          }
          return SafeArea(
            child: CustomAppPadding(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppSizedBox.sizedBox20H,
                      Center(
                          child: UserProfileImg(
                        userProfile: _userProfile,
                        profilePic: _profileImage,
                      )),
                      AppSizedBox.sizedBox15H,
                      CustomTextField(
                          showPrefixIcon: false,
                          controller: _nameController,
                          showSuffixIcon: false,
                          hintText: 'Full Name',
                          validation: Validation.simpleValidation,
                          obsecureText: false),
                      AppSizedBox.sizedBox15H,
                      CustomTextField(
                        showPrefixIcon: false,
                        controller: _phoneNoController,
                        hintText: 'Phone Number',
                        validation: Validation.phoneNoValidation,
                      ),
                      AppSizedBox.sizedBox15H,
                      CustomTextField(
                        showPrefixIcon: false,
                        controller: _occupationController,
                        hintText: 'Occupation',
                      ),
                      AppSizedBox.sizedBox15H,
                      CustomTextField(
                        showPrefixIcon: false,
                        controller: _aboutController,
                        hintText: 'About',
                        maxLine: 3,
                      ),
                      AppSizedBox.sizedBox15H,
                      CustomButton(
                          child: Text(
                            'Update',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w600, color: Colors.white, fontSize: !isThatMobile ? 13 : null),
                          ),
                          onClick: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<ProfileBloc>().add(UpdateProfilEvent(
                                    userProfil: _profileImage,
                                    fullName: _nameController.text.trim(),
                                    phoneNumber: _phoneNoController.text.trim(),
                                    occupation:
                                        _occupationController.text.trim(),
                                    about: _aboutController.text.trim(),
                                    profilePic: _userProfile.value,
                                    uid: appUser.id,
                                  ));
                            }
                          })
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
