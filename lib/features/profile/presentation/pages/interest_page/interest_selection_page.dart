import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/app_info_dialog.dart';
import 'package:social_media_app/core/const/app_msg/app_info_msg.dart';
import 'package:social_media_app/core/const/interest_list.dart';
import 'package:social_media_app/core/routes/app_routes_const.dart';
import 'package:social_media_app/core/widgets/app_related/app_custom_appbar.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/core/widgets/welcome_msg/welcome_msg.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile_bloc/index.dart';
import 'package:social_media_app/features/profile/presentation/widgets/interest_selection/choice_chips.dart';
import 'package:social_media_app/features/profile/presentation/widgets/next_button.dart';
import 'package:social_media_app/features/profile/presentation/widgets/next_icon.dart';

class InterestSelectionPage extends StatefulWidget {
  const InterestSelectionPage({super.key, this.alreadySelectedInterests});
  final List<String>? alreadySelectedInterests;
  @override
  State<InterestSelectionPage> createState() => _InterestSelectionPageState();
}

class _InterestSelectionPageState extends State<InterestSelectionPage> {
  final ValueNotifier<bool> _isSelected = ValueNotifier(false);
  List<String> _selectedInterests = [];
  @override
  void initState() {
    super.initState();
    if (widget.alreadySelectedInterests != null) {
      _selectedInterests = widget.alreadySelectedInterests!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomAppbar(
        showLeading: true,
      ),
      floatingActionButton: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileInterestsSet) {
            context.pushNamed(MyAppRouteConst.locationPageRoute, extra: true);
          }
          if (state is ProfileInterestEmptyState) {
            return AppInfoDialog.showInfoDialog(
              context: context,
              buttonText: 'Skip',
              callBack: () => context
                  .pushNamed(MyAppRouteConst.locationPageRoute, extra: true),
              title: AppIngoMsg.interestEmptyTitle,
              subtitle: AppIngoMsg.interestEmptyinfo,
            );
          }
        },
        child: NextButton(
            onpressed: () {
              context.read<ProfileBloc>().add(
                  ProfileInterestSelectedEvent(interests: _selectedInterests));
            },
            child: const NextIcon()),
      ),
      body: SafeArea(
        child: CustomAppPadding(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSizedBox.sizedBox40H,
                const WelcomeMessage(
                    title1: 'Choose Your', title2: 'Interests'),
                AppSizedBox.sizedBox20H,
                Wrap(
                  spacing: 10.w,
                  runSpacing: 10.h,
                  children: interests.map((interest) {
                    return ValueListenableBuilder(
                      valueListenable: _isSelected,
                      builder: (context, isSelected, child) {
                        return CustomChoiceChip(
                          selected: _selectedInterests,
                          chipLabel: interest,
                          isSelected: isSelected,
                          onSelected: (value) {
                            // _isSelected.value = value;
                            // print(_selectedInterests);
                          },
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
