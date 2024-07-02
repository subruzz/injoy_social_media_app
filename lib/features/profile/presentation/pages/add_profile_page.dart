import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:social_media_app/core/common/entities/user.dart';
import 'package:social_media_app/core/const/app_sizedbox.dart';
import 'package:social_media_app/core/shared_providers/cubits/pick_single_image/pick_image_cubit.dart';
import 'package:social_media_app/core/utils/functions/date_picker.dart';
import 'package:social_media_app/core/utils/validations/validations.dart';
import 'package:social_media_app/features/profile/presentation/pages/interest_selection_page.dart';
import 'package:social_media_app/features/profile/presentation/widgets/add_profile/add_profile_top_text.dart';
import 'package:social_media_app/features/profile/presentation/widgets/add_profile/user_profile_pic.dart';
import 'package:social_media_app/features/profile/presentation/widgets/next_button.dart';

import '../../../../core/widgets/textfields/details_add_text.dart';

class AddProfilePage extends StatefulWidget {
  const AddProfilePage({super.key, required this.appUser});
  final AppUser appUser;
  @override
  State<AddProfilePage> createState() => _AddProfilePageState();
}

class _AddProfilePageState extends State<AddProfilePage> {
  final ValueNotifier<TextEditingController> _selectedDate =
      ValueNotifier(TextEditingController());
  final _nameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _phoneNoController = TextEditingController();
  final _occupationController = TextEditingController();
  final _aboutController = TextEditingController();
  final _selectImageCuit = GetIt.instance<PickSingleImageCubit>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _nameController.dispose();
    _userNameController.dispose();
    _phoneNoController.dispose();
    _occupationController.dispose();
    _aboutController.dispose();
    _selectImageCuit.close();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final String? pickedDate = await pickDate(context);
    if (pickedDate != null) {
      _selectedDate.value.text = pickedDate;
    }
  }

  void profileCompleted() {
    if (_formKey.currentState!.validate()) {
      widget.appUser.fullName = _nameController.text.trim();
      widget.appUser.userName = _userNameController.text.trim();
      widget.appUser.dob = _selectedDate.value.text.trim();
      widget.appUser.phoneNumber = _phoneNoController.text.isNotEmpty
          ? int.parse(_phoneNoController.text.trim())
          : null;
      widget.appUser.occupation = _occupationController.text.isNotEmpty
          ? _occupationController.text.trim()
          : null;
      widget.appUser.about = _aboutController.text.isNotEmpty
          ? _aboutController.text.trim()
          : null;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => InterestSelectionPage(
              userProfil: widget.appUser, profilePic: _selectImageCuit.img),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: NextButton(
        onpressed: () {
          profileCompleted();
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AddProfileTopText(),
                  AppSizedBox.sizedBox40H,
                  UserProfilePicSelect(selectImageCuit: _selectImageCuit),
                  AppSizedBox.sizedBox15H,
                  CustomTextField(
                      showPrefixIcon: false,
                      controller: _nameController,
                      showSuffixIcon: false,
                      hintText: 'Full Name',
                      validation: Validation.simpleValidation,
                      obsecureText: false),
                  AppSizedBox.sizedBox20H,
                  CustomTextField(
                      showPrefixIcon: false,
                      controller: _userNameController,
                      showSuffixIcon: false,
                      hintText: 'Username',
                      validation: Validation.simpleValidation,
                      obsecureText: false),
                  AppSizedBox.sizedBox15H,
                  ValueListenableBuilder(
                    valueListenable: _selectedDate,
                    builder: (context, value, child) {
                      return CustomTextField(
                        showPrefixIcon: false,
                        readOnly: true,
                        controller: value,
                        showSuffixIcon: true,
                        hintText: 'Date of birth',
                        datePicker: _pickDate,
                        obsecureText: false,
                        
                        validation: Validation.simpleValidation,
                      );
                    },
                  ),
                  AppSizedBox.sizedBox15H,
                  CustomTextField(
                      showPrefixIcon: false,
                      controller: _phoneNoController,
                      showSuffixIcon: false,
                      hintText: 'Phone Number',
                      validation: Validation.phoneNoValidation,
                      obsecureText: false),
                  AppSizedBox.sizedBox15H,
                  CustomTextField(
                      showPrefixIcon: false,
                      controller: _occupationController,
                      showSuffixIcon: false,
                      hintText: 'Occupation',
                      obsecureText: false),
                  AppSizedBox.sizedBox15H,
                  CustomTextField(
                      showPrefixIcon: false,
                      controller: _aboutController,
                      showSuffixIcon: false,
                      hintText: 'About',
                      maxLine: 3,
                      obsecureText: false ),
                  AppSizedBox.sizedBox15H,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
