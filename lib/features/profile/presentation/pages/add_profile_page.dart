import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/widgets/app_related/app_custom_appbar.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/core/widgets/common/common_text_button.dart';
import 'package:social_media_app/core/widgets/web/web_width_helper.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile/user_profile_bloc/index.dart';

import 'package:social_media_app/features/profile/presentation/widgets/add_profile/profile_form.dart';

class AddProfilePage extends StatefulWidget {
  const AddProfilePage({super.key});

  @override
  State<AddProfilePage> createState() => _AddProfilePageState();
}

class _AddProfilePageState extends State<AddProfilePage> {
  final _nameController = TextEditingController();
  final _phoneNoController = TextEditingController();
  final _occupationController = TextEditingController();
  final _aboutController = TextEditingController();
  final _dobController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final bool isValid = false;
  final ValueNotifier<(File?, Uint8List?)> _userProfile =
      ValueNotifier((null, null));
  @override
  void dispose() {
    _nameController.dispose();
    _phoneNoController.dispose();
    _occupationController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  void _profileCompleted(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<ProfileBloc>().add(ProfileSetUpUserDetailsEvent(
          fullName: _nameController.text.trim(),
          phoneNumber: _phoneNoController.text.trim(),
          occupation: _occupationController.text.trim(),
          about: _aboutController.text.trim(),
          profilePic: _userProfile.value.$1,
          webImage: _userProfile.value.$2,
          dob: _dobController.text.trim(),
          uid: context.read<AppUserBloc>().appUser.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomAppbar(
        title: 'Fill Your Profile',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: WebWidthHelper(
        btwMobAndTab: true,
        child: CustomAppPadding(
          child: SingleChildScrollView(
            child: ProfileForm(
              onPress: () {
                _profileCompleted(context);
              },
              formKey: _formKey,
              nameController: _nameController,
              phoneNoController: _phoneNoController,
              occupationController: _occupationController,
              aboutController: _aboutController,
              dobController: _dobController,
              selectImage: _userProfile,
            ),
          ),
        ),
      ),
    );
  }
}
