import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/shared_providers/cubits/pick_single_image/pick_image_cubit.dart';
import 'package:social_media_app/core/widgets/app_related/app_custom_appbar.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/core/widgets/common_text_button.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile_bloc/index.dart';

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
  final _selectImageCubit = GetIt.instance<PickSingleImageCubit>();
  final _dobController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final bool isValid = false;
  @override
  void dispose() {
    _nameController.dispose();
    _phoneNoController.dispose();
    _occupationController.dispose();
    _aboutController.dispose();
    _selectImageCubit.close();
    super.dispose();
  }

  void _profileCompleted(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<ProfileBloc>().add(ProfileSetUpUserDetailsEvent(
          fullName: _nameController.text.trim(),
          phoneNumber: _phoneNoController.text.trim(),
          occupation: _occupationController.text.trim(),
          about: _aboutController.text.trim(),
          profilePic: _selectImageCubit.img,
          dob: _dobController.text.trim(),
          uid: context.read<AppUserBloc>().appUser.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomAppbar(
        title: 'Fill Your Profile',
        actions: [
          Padding(
            padding: AppPadding.onlyRightSmall,
            child: CommonTextButton(
              text: 'Skip',
              onPressed: () {},
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: CustomAppPadding(
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
            selectImageCubit: _selectImageCubit,
          ),
        ),
      ),
    );
  }
}
