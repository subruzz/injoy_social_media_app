import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/const/app_config/app_border_radius.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/extensions/localization.dart';
import 'package:social_media_app/core/const/languages/app_languages.dart';
import 'package:social_media_app/core/utils/responsive/constants.dart';
import 'package:social_media_app/core/widgets/messenger/messenger.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_event.dart';
import 'package:social_media_app/core/utils/other/debouncer.dart';
import 'package:social_media_app/core/widgets/app_related/app_custom_appbar.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/core/widgets/button/custom_elevated_button.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/core/widgets/common/overlay_loading_holder.dart';
import 'package:social_media_app/core/widgets/web/web_width_helper.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile/user_name_cubit/user_name_cubit.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile/user_profile_bloc/index.dart';
import 'package:social_media_app/features/profile/presentation/widgets/add_profile/index.dart';
import 'package:social_media_app/core/utils/di/init_dependecies.dart';

import '../../../../core/utils/responsive/responsive_helper.dart';
import '../../../bottom_nav/presentation/pages/bottom_bar_builder.dart';
import '../../../bottom_nav/presentation/web/web_layout.dart';

class UsernameCheckPage extends StatefulWidget {
  const UsernameCheckPage(
      {super.key, this.isEdit = false, required this.userid});
  final bool isEdit;
  final String userid;
  @override
  State<UsernameCheckPage> createState() => _CreateUsernamePageState();
}

class _CreateUsernamePageState extends State<UsernameCheckPage> {
  final TextEditingController _usernameController = TextEditingController();
  final _userNameCubit = serviceLocator<UserNameCubit>();
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 500));
  AppUser? appUser;
  @override
  void initState() {
    if (widget.isEdit) {
      appUser = context.read<AppUserBloc>().appUser;

      _usernameController.text = appUser?.userName ?? '';
      _userNameCubit.setSuccess();
    }
    super.initState();
  }

  @override
  void dispose() {
    _debouncer.cancel();
    _userNameCubit.close();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n!;
    return Scaffold(
      appBar: AppCustomAppbar(
        showLeading: true,
      ),
      body: WebWidthHelper(
        btwMobAndTab: true,
        child: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is CompleteProfileSetupSuceess) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const Responsive(
                    mobile: BottomBarBuilder(),
                    tablet: WebLayout(),
                    desktop: WebLayout(),
                  ),
                ),
                (route) => false, 
              );
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                CustomAppPadding(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          widget.isEdit
                              ? l10n.changeUsername
                              : 'Create a username',
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                  fontSize:
                                      AppLanguages.isMalayalamLocale(context)
                                          ? 20
                                          : 25,
                                  fontWeight: FontWeight.w700)),
                      AppSizedBox.sizedBox5H,
                      Text(
                        l10n.chooseUsername,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: isThatMobile ? null : 14),
                      ),
                      AppSizedBox.sizedBox15H,
                      UserNameCheckField(
                          userNameController: _usernameController,
                          debouncer: _debouncer,
                          userNameCubit: _userNameCubit),
                      AppSizedBox.sizedBox15H,
                      BlocConsumer(
                        bloc: _userNameCubit,
                        listener: (context, usernameState) {
                          if (usernameState is AddUserNameSuccess) {
                            final appuser = context.read<AppUserBloc>();
                            appuser.add(UpdateUserModelEvent(
                                userModel: appuser.appUser.copyWith(
                                    userName: usernameState.userName)));
                            Messenger.showSnackBar(message: l10n.usernameAdded);
                            Navigator.pop(context);
                          }
                          if (usernameState is UserNameAvailableState) {
                            // Optionally show a success message or perform an action
                          }
                        },
                        buildWhen: (previous, current) =>
                            current is UserNameAvailableState ||
                            current is UserNameNotAvailableState ||
                            current is UserNameCheckInitial ||
                            current is AddUserNameLoading,
                        builder: (context, usernameState) {
                          return CustomButton(
                            color: usernameState is UserNameAvailableState
                                ? null
                                : const Color.fromARGB(255, 240, 114, 133),
                            onClick: () {
                              if (usernameState is! UserNameAvailableState ||
                                  usernameState is UserNamecheckingLoading ||
                                  _debouncer.isRunning()) {
                                return;
                              }
                              if (widget.isEdit) {
                                if (appUser?.userName ==
                                    _usernameController.text) {
                                  return;
                                }
                                _userNameCubit.setUserName(
                                    _usernameController.text.trim(),
                                    widget.userid);
                                return;
                              }

                              context.read<ProfileBloc>().add(
                                  CompleteProfileSetup(
                                      uid: context
                                          .read<AppUserBloc>()
                                          .appUser
                                          .id,
                                      userName:
                                          _usernameController.text.trim()));
                            },
                            radius: AppBorderRadius.small,
                            child: usernameState is AddUserNameLoading
                                ? const CircularLoading()
                                : Text(
                                    widget.isEdit
                                        ? l10n.change_username
                                        : 'Next',
                                    style: isThatMobile
                                        ? null
                                        : const TextStyle(fontSize: 14),
                                  ),
                          );
                        },
                      )
                    ],
                  ),
                ),
                if (state is CompleteProfileSetupLoading)
                  const OverlayLoadingHolder(
                    wantLoadingGif: true,
                  )
              ],
            );
          },
        ),
      ),
    );
  }
}
