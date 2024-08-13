import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_border_radius.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/utils/other/debouncer.dart';
import 'package:social_media_app/core/widgets/app_related/app_custom_appbar.dart';
import 'package:social_media_app/core/widgets/button/custom_elevated_button.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile/user_name_cubit/user_name_cubit.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile/user_profile_bloc/profile_state.dart';
import 'package:social_media_app/core/utils/di/init_dependecies.dart';

import '../../../../core/utils/functions/date_picker.dart';
import '../../../../core/utils/validations/validations.dart';
import '../../../../core/widgets/textfields/custom_textform_field.dart';

class DateOfBirthPage extends StatefulWidget {
  const DateOfBirthPage({super.key, this.dob});
  final String? dob;
  @override
  State<DateOfBirthPage> createState() => _CreateUsernamePageState();
}

class _CreateUsernamePageState extends State<DateOfBirthPage> {
  final TextEditingController _dateofBirthController = TextEditingController();
  @override
  void dispose() {
    _dateofBirthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomAppbar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enter your date of birth',
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(fontWeight: FontWeight.w700)),
            AppSizedBox.sizedBox5H,
            Text(
              "Please enter your date of birth. This information helps us provide a better experience and ensure age-appropriate content.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            AppSizedBox.sizedBox15H,
            CustomTextField(
              readOnly: true,
              controller: _dateofBirthController,
              showSuffixIcon: true,
              hintText: 'Date of Birth',
              datePicker: () async {
                final String? dob = await pickDate(context);

                if (dob != null) {
                  _dateofBirthController.text = dob;
                }
              },
              validation: Validation.dateOfBirthValidation,
            ),
            AppSizedBox.sizedBox15H,
            CustomButton(
              onClick: () {
                FirebaseAuth.instance.signOut();
              },
              radius: AppBorderRadius.small,
              child: const Text('Next'),
            )
          ],
        ),
      ),
    );
  }
}
