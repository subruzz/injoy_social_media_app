import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/shared_providers/cubits/pick_single_image/pick_image_cubit.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile_bloc/index.dart';
import 'package:social_media_app/features/profile/presentation/widgets/add_profile/add_profile_button.dart';
import 'package:social_media_app/features/profile/presentation/widgets/add_profile/index.dart';
import 'package:social_media_app/features/profile/presentation/widgets/add_profile/profile_form.dart';

class AddProfilePage extends StatefulWidget {
  const AddProfilePage({super.key, required this.appUser});
  final AppUser appUser;

  @override
  State<AddProfilePage> createState() => _AddProfilePageState();
}

class _AddProfilePageState extends State<AddProfilePage> {
  final _nameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _phoneNoController = TextEditingController();
  final _occupationController = TextEditingController();
  final _aboutController = TextEditingController();
  final _selectImageCubit = GetIt.instance<PickSingleImageCubit>();
  final _dobController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _userNameController.dispose();
    _phoneNoController.dispose();
    _occupationController.dispose();
    _aboutController.dispose();
    _selectImageCubit.close();
    super.dispose();
  }

  void _profileCompleted() {
    if (_formKey.currentState!.validate()) {
      context.read<ProfileBloc>().add(ProfileSetUpUserDetailsEvent(
          fullName: _nameController.text.trim(),
          userName: _userNameController.text.trim(),
          phoneNumber: _phoneNoController.text.trim(),
          occupation: _occupationController.text.trim(),
          about: _aboutController.text.trim(),
          profilePic: _selectImageCubit.img,
          dob: _dobController.text.trim(),
          uid: widget.appUser.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AddProfileButton(onPressed: _profileCompleted),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          const SliverAppBar(
            title: AddProfileTopText(),
            pinned: true,
            floating: true,
            snap: true,
          ),
        ],
        body: CustomAppPadding(
          child: SingleChildScrollView(
            child: ProfileForm(
              formKey: _formKey,
              nameController: _nameController,
              userNameController: _userNameController,
              phoneNoController: _phoneNoController,
              occupationController: _occupationController,
              aboutController: _aboutController,
              dobController: _dobController,
              selectImageCubit: _selectImageCubit,
            ),
          ),
        ),
      ),
    );
  }
}
