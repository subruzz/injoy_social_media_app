import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/const/extensions/localization.dart';
import 'package:social_media_app/features/profile/presentation/widgets/others_profile/other_user_details.dart';
import 'package:social_media_app/features/profile/presentation/widgets/user_profile_page/top_bar_section/top_bar_section.dart';
import 'package:social_media_app/features/profile/presentation/widgets/user_profile_page/user_basic_details_section/user_basic_detail_section.dart';
import '../../../../core/const/app_config/app_sizedbox.dart';
import '../widgets/user_profile_page/user_profile_tab_section/user_profile_tab_section.dart';
import '../widgets/user_profile_page/user_social_action_details_section/user_social_action_details_section.dart';

class ProfilePageWrapper extends StatelessWidget {
  const ProfilePageWrapper({super.key, this.userName, this.isMe = true});
  final String? userName;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    final user = context.read<AppUserBloc>().appUser;
    final l10n = context.l10n;
    return Scaffold(
      appBar: ProfilePageTopBarSection(
        userName: userName,
        isMe: userName == null,
        localization: l10n,
      ),
      body: Center(
        child: SizedBox(
          child: DefaultTabController(
            length: 2,
            child: NestedScrollView(
              headerSliverBuilder: (_, __) {
                return [
                  SliverList(
                      delegate: SliverChildListDelegate([
                    Column(
                      children: [
                        isMe
                            ? Column(
                                children: [
                                  const MyProfileBasicDetails(),
                                  AppSizedBox.sizedBox15H,
                                  UserSocialActionDetailsSection(
                                    localizations: l10n,
                                    user: user,
                                  ),
                                ],
                              )
                            : OtherUserDetails(l10n: l10n)
                      ],
                    ),
                  ]))
                ];
              },
              body: UserProfileTabSection(
                isMe: isMe,
                localizations: l10n!,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
