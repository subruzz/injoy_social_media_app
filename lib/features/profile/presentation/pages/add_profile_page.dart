import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_app/core/const/app_sizedbox.dart';
import 'package:social_media_app/core/extensions/datetime_to_string.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/wigets/text_field.dart';
import 'package:social_media_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:social_media_app/features/profile/presentation/bloc/profile_event.dart';
import 'package:social_media_app/features/profile/presentation/bloc/profile_state.dart';
import 'package:social_media_app/features/profile/presentation/pages/interest_selection_page.dart';
import 'package:social_media_app/features/profile/presentation/widgets/next_button.dart';

class AddProfilePage extends StatefulWidget {
  const AddProfilePage({super.key});

  @override
  State<AddProfilePage> createState() => _AddProfilePageState();
}

class _AddProfilePageState extends State<AddProfilePage> {
  final _nameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _phoneNoController = TextEditingController();
  final _occupationController = TextEditingController();
  final _aboutController = TextEditingController();
  File? _selectedImage;
  String _selectedDate = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void selecteImage() async {
    final ImagePicker imgPicker = ImagePicker();
    final result = await imgPicker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      setState(() {
        _selectedImage = File(result.path);
      });
    } else {
      // User canceled the picker
    }
  }

  void sumbitData() {
    if (_nameController.text.isEmpty || _userNameController.text.isEmpty) {
      return;
    }
  }

  Future<void> _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate.toFormattedString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUserDetailsSet) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InterestSelectionPage(
                userProfil: state.userProfile,
                profilePic: state.profileImag,
              ),
            ),
          );
        }
      },
      child: Scaffold(
        floatingActionButton: NextButton(
          onpressed: () {
            if (_formKey.currentState!.validate()) {
              final String fullName = _nameController.text.trim();
              final String userName = _userNameController.text.trim();
              final String? phoneNumber = _phoneNoController.text.isNotEmpty
                  ? _phoneNoController.text.trim()
                  : null;
              final String? occupation = _occupationController.text.isNotEmpty
                  ? _occupationController.text.trim()
                  : null;
              final String? about = _aboutController.text.isNotEmpty
                  ? _aboutController.text.trim()
                  : null;

              // Dispatch an event to the ProfileBloc to submit the data
              context.read<ProfileBloc>().add(
                    ProfileSetUpUserDetailsEvent(
                      fullName: fullName,
                      userName: userName,
                      dob: _selectedDate, // Use the selected date
                      phoneNumber:
                          phoneNumber != null ? int.parse(phoneNumber) : null,
                      occupation: occupation,
                      about: about,
                      profilePic: _selectedImage,
                    ),
                  );

              // // Navigate to the next page
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => InterestSelectionPage(),
              //   ),
              // );
            }
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
                    Text(
                      'Fill Your Profile',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    AppSizedBox.sizedBox40H,
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 70,
                            backgroundImage: _selectedImage == null
                                ? const AssetImage(
                                    'assets/images/profile_icon.png')
                                : FileImage(_selectedImage!),
                          ),
                          Positioned(
                            right: 20,
                            bottom: 0,
                            child: GestureDetector(
                              onTap: () {
                                selecteImage();
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
                    CustomTextField(
                        showPrefixIcon: false,
                        controller: _nameController,
                        showSuffixIcon: true,
                        hintText: _selectedDate.isEmpty
                            ? 'Date of birth'
                            : _selectedDate,
                        datePicker: _pickDate,
                        obsecureText: false),
                    AppSizedBox.sizedBox15H,
                    CustomTextField(
                        showPrefixIcon: false,
                        controller: _phoneNoController,
                        showSuffixIcon: false,
                        hintText: 'Phone Number',
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
        ),
      ),
    );
  }
}
