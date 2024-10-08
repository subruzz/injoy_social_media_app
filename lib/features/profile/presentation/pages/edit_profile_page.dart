import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/utils/extensions/localization.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/utils/validations/validations.dart';
import 'package:social_media_app/core/widgets/common/app_custom_appbar.dart';
import 'package:social_media_app/core/widgets/common/app_padding.dart';
import 'package:social_media_app/core/widgets/button/custom_elevated_button.dart';
import 'package:social_media_app/core/widgets/common/overlay_loading_holder.dart';
import 'package:social_media_app/core/widgets/messenger/messenger.dart';
import 'package:social_media_app/core/widgets/textfields/custom_textform_field.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile/user_profile_bloc/profile_bloc.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile/user_profile_bloc/profile_event.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile/user_profile_bloc/profile_state.dart';
import 'package:social_media_app/features/profile/presentation/widgets/add_profile/user_profile_img.dart';

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
  final ValueNotifier<(File?, Uint8List?)> _userProfile =
      ValueNotifier((null, null));
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
    final l10n = context.l10n!;
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is CompleteProfileSetupSuceess) {
          Messenger.showSnackBar(message: l10n.profileUpdated);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
                appBar: AppCustomAppbar(
                  title: l10n.editProfile,
                ),
                body: SafeArea(
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
                                  l10n.update,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          fontSize: !isThatMobile ? 13 : null),
                                ),
                                onClick: () {
                                  if (_formKey.currentState!.validate()) {
                                    context
                                        .read<ProfileBloc>()
                                        .add(UpdateProfilEvent(
                                          userProfil: _profileImage,
                                          fullName: _nameController.text.trim(),
                                          phoneNumber:
                                              _phoneNoController.text.trim(),
                                          occupation:
                                              _occupationController.text.trim(),
                                          about: _aboutController.text.trim(),
                                          profilePic: _userProfile.value.$1,
                                          webImg: _userProfile.value.$2,
                                          uid: appUser.id,
                                        ));
                                  }
                                })
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
            if (state is CompleteProfileSetupLoading)
              const OverlayLoadingHolder()
          ],
        );
      },
    );
  }
}
