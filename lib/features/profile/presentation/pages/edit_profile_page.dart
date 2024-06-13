import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/bloc/app_user_bloc.dart';
import 'package:social_media_app/core/common/entities/user.dart';

import 'package:social_media_app/core/const/app_sizedbox.dart';
import 'package:social_media_app/core/extensions/number_only_string.dart';
import 'package:social_media_app/core/utils/functions/date_picker.dart';
import 'package:social_media_app/core/utils/functions/image_picker.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:social_media_app/features/profile/presentation/bloc/profile_event.dart';
import 'package:social_media_app/features/profile/presentation/bloc/profile_state.dart';
import 'package:social_media_app/features/profile/presentation/pages/interest_selection_page.dart';
import 'package:social_media_app/features/profile/presentation/widgets/next_button.dart';

import '../../../../core/wigets/text_field.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.appUser});
  final AppUser appUser;
  @override
  State<EditProfilePage> createState() => _AddProfilePageState();
}

class _AddProfilePageState extends State<EditProfilePage> {
  final ValueNotifier<File?> _selectedImage = ValueNotifier(null);
  final ValueNotifier<TextEditingController> _selectedDate =
      ValueNotifier(TextEditingController());
  final _nameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _phoneNoController = TextEditingController();
  final _occupationController = TextEditingController();
  final _aboutController = TextEditingController();
  String? _profileImage;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _profileImage = widget.appUser.profilePic;
    _nameController.text = widget.appUser.fullName;
    _userNameController.text = widget.appUser.userName;
    _phoneNoController.text = widget.appUser.phoneNumber.toString();
    _occupationController.text = widget.appUser.occupation ?? '';
    _selectedDate.value.text = widget.appUser.dob;
    _aboutController.text = widget.appUser.about ?? '';
  }

  Future<void> pickImage() async {
    final result = await selecteImage();
    if (result != null) {
      _selectedImage.value = File(result.path);
      _profileImage = null;
    } else {}
  }

  void sumbitData() {
    if (_formKey.currentState!.validate()) {
      return;
    }
  }

  Future<void> _pickDate() async {
    final String? pickedDate = await pickDate(context);
    if (pickedDate != null) {
      _selectedDate.value.text = pickedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Your Profile',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      floatingActionButton: NextButton(
        onpressed: () {
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
            context.read<ProfileBloc>().add(ProfileSetUpLocationEvent(
                userProfile: widget.appUser, profilePic: _selectedImage.value));
          }
        },
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileSubmissionSuccess) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppSizedBox.sizedBox20H,
                      Center(
                        child: Stack(
                          children: [
                            ValueListenableBuilder(
                              valueListenable: _selectedImage,
                              builder: (context, value, child) {
                                return CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: 70,
                                  backgroundImage: _profileImage != null
                                      ? NetworkImage(_profileImage!)
                                      : value == null
                                          ? const AssetImage(
                                              'assets/images/profile_icon.png')
                                          : FileImage(value),
                                );
                              },
                            ),
                            Positioned(
                              right: 20,
                              bottom: 0,
                              child: GestureDetector(
                                onTap: () {
                                  pickImage();
                                },
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2.0),
                                    color: AppDarkColor().buttonBackground,
                                  ),
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                    size: 13,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      AppSizedBox.sizedBox15H,
                      CustomTextField(
                          showPrefixIcon: false,
                          controller: _nameController,
                          showSuffixIcon: false,
                          hintText: 'Full Name',
                          validation: (val) {
                            if (val!.isEmpty) {
                              return "Please fill in this field";
                            }
                            return null;
                          },
                          obsecureText: false),
                      AppSizedBox.sizedBox20H,
                      CustomTextField(
                          showPrefixIcon: false,
                          controller: _userNameController,
                          showSuffixIcon: false,
                          hintText: 'Username',
                          validation: (val) {
                            if (val!.isEmpty) {
                              return "Please fill in this field";
                            }
                            return null;
                          },
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
                            validation: (val) {
                              if (val!.isEmpty) {
                                return "Please fill in this field";
                              }
                              return null;
                            },
                          );
                        },
                      ),
                      AppSizedBox.sizedBox15H,
                      CustomTextField(
                          showPrefixIcon: false,
                          controller: _phoneNoController,
                          showSuffixIcon: false,
                          hintText: 'Phone Number',
                          validation: (val) {
                            if (val!.isEmpty) {
                              return null;
                            }
                            if (!val.isPhoneNo()) {
                              return "Please fill in this field";
                            }
                            return null;
                          },
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
                          obsecureText: false),
                      AppSizedBox.sizedBox15H,
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
