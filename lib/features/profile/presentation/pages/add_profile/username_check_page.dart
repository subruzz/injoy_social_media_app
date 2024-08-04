import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_border_radius.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/routes/app_routes_const.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/utils/debouncer.dart';
import 'package:social_media_app/core/widgets/app_related/app_custom_appbar.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/core/widgets/button/custom_elevated_button.dart';
import 'package:social_media_app/core/widgets/overlay_loading_holder.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_name_cubit/user_name_cubit.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile_bloc/index.dart';
import 'package:social_media_app/features/profile/presentation/widgets/add_profile/index.dart';
import 'package:social_media_app/init_dependecies.dart';

class UsernameCheckPage extends StatefulWidget {
  const UsernameCheckPage({super.key, this.userName});
  final String? userName;
  @override
  State<UsernameCheckPage> createState() => _CreateUsernamePageState();
}

class _CreateUsernamePageState extends State<UsernameCheckPage> {
  final TextEditingController _usernameController = TextEditingController();
  final _userNameCubit = serviceLocator<UserNameCubit>();
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 500));
  @override
  void dispose() {
    _debouncer.cancel();
    _userNameCubit.close();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomAppbar(
        showLeading: true,
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is CompleteProfileSetupSuceess) {
            Navigator.pushNamed(context, MyAppRouteConst.bottomNavRoute);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              CustomAppPadding(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Create a username',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium
                            ?.copyWith(fontWeight: FontWeight.w700)),
                    AppSizedBox.sizedBox5H,
                    Text(
                      "Choose a username for your profile. You can change it later if you want.",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    AppSizedBox.sizedBox15H,
                    UserNameCheckField(
                        userNameController: _usernameController,
                        debouncer: _debouncer,
                        userNameCubit: _userNameCubit),
                    AppSizedBox.sizedBox15H,
                    BlocBuilder(
                      buildWhen: (previous, current) =>
                          current is UserNameAvailableState ||
                          current is UserNameNotAvailableState ||
                          current is UserNameCheckInitial,
                      bloc: _userNameCubit,
                      builder: (context, usernameState) {
                        return CustomButton(
                          color: usernameState is UserNameAvailableState
                              ? null
                              : (const Color.fromARGB(255, 240, 114, 133)),
                          onClick: () {
                            if (usernameState is UserNameAvailableState) {
                              context.read<ProfileBloc>().add(
                                  CompleteProfileSetup(
                                      uid: context
                                          .read<AppUserBloc>()
                                          .appUser
                                          .id,
                                      userName:
                                          _usernameController.text.trim()));
                            }
                          },
                          radius: AppBorderRadius.small,
                          child: const Text('Next'),
                        );
                      },
                    ),
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
    );
  }
}
