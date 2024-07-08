import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/shared_providers/cubits/pick_single_image/pick_image_cubit.dart';
import 'package:social_media_app/core/utils/functions/date_picker.dart';
import 'package:social_media_app/core/utils/validations/validations.dart';
import 'package:social_media_app/core/widgets/button/custom_elevated_button.dart';
import 'package:social_media_app/core/widgets/loading/loading_bar.dart';
import 'package:social_media_app/core/widgets/textfields/custom_textform_field.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile_bloc/profile_bloc.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile_bloc/profile_event.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile_bloc/profile_state.dart';
import 'package:social_media_app/features/profile/presentation/widgets/add_profile/user_profile_pic.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.appUser});
  final AppUser appUser;
  @override
  State<EditProfilePage> createState() => _AddProfilePageState();
}

class _AddProfilePageState extends State<EditProfilePage> {
  final ValueNotifier<TextEditingController> _selectedDate =
      ValueNotifier(TextEditingController());
  final _nameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _phoneNoController = TextEditingController();
  final _occupationController = TextEditingController();
  final _aboutController = TextEditingController();
  String? _profileImage;
  final _selectImageCuit = GetIt.instance<PickSingleImageCubit>();
  List<String> _selectedInterest = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _selectedInterest = widget.appUser.interests;
    _profileImage = widget.appUser.profilePic;
    _nameController.text = widget.appUser.fullName ?? '';
    _userNameController.text = widget.appUser.userName ?? '';
    _phoneNoController.text = widget.appUser.phoneNumber ?? '';
    _occupationController.text = widget.appUser.occupation ?? '';
    _selectedDate.value.text = widget.appUser.dob ?? '';
    _aboutController.text = widget.appUser.about ?? '';
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
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppSizedBox.sizedBox20H,
                      UserProfilePicSelect(
                        clearImage: () {
                          _profileImage = null;
                        },
                        selectImageCuit: _selectImageCuit,
                        userImage: _profileImage,
                      ),
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
                          obsecureText: false),
                      AppSizedBox.sizedBox15H,
                      CustomButton(
                          child: const Text('Update'),
                          onClick: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<ProfileBloc>().add(UpdateProfilEvent(
                                
                                  fullName: _nameController.text.trim(),
                                  userName: _userNameController.text.trim(),
                                  dob: _selectedDate.value.text.trim(),
                                  phoneNumber: _phoneNoController.text.trim(),
                                  occupation: _occupationController.text.trim(),
                                  about: _aboutController.text.trim(),
                                  profilePic: _selectImageCuit.img,
                                  uid: widget.appUser.id,
                                  location: null));
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
