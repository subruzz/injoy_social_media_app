import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/app_info_dialog.dart';
import 'package:social_media_app/core/const/app_msg/app_info_msg.dart';
import 'package:social_media_app/core/const/assets/app_assets.dart';
import 'package:social_media_app/core/const/location_enum.dart';
import 'package:social_media_app/core/const/messenger.dart';
import 'package:social_media_app/core/routes/app_routes_const.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/animated/app_lottie_animation.dart';
import 'package:social_media_app/core/widgets/app_related/app_custom_appbar.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/core/widgets/app_related/common_text.dart';
import 'package:social_media_app/core/widgets/button/custom_elevated_button.dart';
import 'package:social_media_app/core/widgets/custom_divider.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/core/widgets/textfields/custom_textform_field.dart';
import 'package:social_media_app/features/location/domain/entities/location.dart';
import 'package:social_media_app/features/location/presentation/blocs/location_bloc/location_bloc.dart';
import 'package:social_media_app/features/location/presentation/widgets/location_dialog.dart';
import 'package:social_media_app/features/post_status_feed/presentation/bloc/following_post_feed/following_post_feed_bloc.dart';
import 'package:social_media_app/features/profile/presentation/bloc/get_user_posts_bloc/get_user_posts_bloc.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile_bloc/index.dart';
import 'package:social_media_app/features/profile/presentation/pages/profile_loading.dart';

class LocationAskingPage extends StatelessWidget {
  const LocationAskingPage({super.key,required this.isFirstTime});
  final bool isFirstTime;
  void submitProfile(BuildContext context, UserLocation? location) {
    context.read<ProfileBloc>().add(CompleteProfileSetup(
        location: location, uid: context.read<AppUserBloc>().appUser.id));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is CompleteProfileSetupSuceess) {
              final user = context.read<AppUserBloc>().appUser;
              context
                  .read<FollowingPostFeedBloc>()
                  .add(FollowingPostFeedGetEvent(uId: user.id));
              context
                  .read<GetUserPostsBloc>()
                  .add(GetUserPostsrequestedEvent(uid: user.id));
              context.goNamed(MyAppRouteConst.bottomNavRoute);
            }
            if (state is CompleteProfileSetupFailure) {
              Messenger.showSnackBar(message: state.errorMsg);
            }
          },
        ),
        BlocListener<LocationBloc, LocationState>(
          listener: (context, state) {
            if (state is LocationSuccess) {
              isFirstTime
                  ? AppInfoDialog.showInfoDialog(
                      context: context,
                      callBack: () {
                        submitProfile(context, state.location);
                      },
                      title: 'Selected Location',
                      subtitle: state.location.currentLocation ?? '',
                      buttonText: 'Continue')
                  : Navigator.pop(context, state.location);
            }
            if (state is LocationNotOnState) {
              showLocationDialog(
                  context: context,
                  locationStatus: LocationStatus.locationNotEnabled);
            }
            if (state is LocationPermissionDenied ||
                state is LocatonPermissionForeverDenied) {
              showLocationDialog(
                  context: context,
                  locationStatus: LocationStatus.locationPermissionDenied);
            }
          },
        ),
      ],
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is CompleteProfileSetupLoading) {
            return const AppLoadingGif();
          }
          return Scaffold(
            appBar: AppCustomAppbar(
              showLeading: true,
              actions: [
                if (isFirstTime)
                  TextButton(
                    onPressed: () {
                      AppInfoDialog.showInfoDialog(
                          context: context,
                          callBack: () {
                            submitProfile(context, null);
                          },
                          title: 'Are You Sure?',
                          subtitle: AppIngoMsg.locationSkip,
                          buttonText: 'Skip');
                    },
                    child: CustomText(
                      'Skip',
                      style:
                          TextStyle(color: AppDarkColor().secondaryPrimaryText),
                    ),
                  )
              ],
            ),
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: CustomAppPadding(
                child: Column(
                  children: [
                    AppSizedBox.sizedBox15H,
                    const CustomTextField(
                      hintText: 'Search manually..',
                      prefixIcon: Icons.search,
                    ),
                    if (isFirstTime)
                      const AppLottieAnimation(
                        lottie: AppAssetsConst.location,
                      ),
                    if (isFirstTime)
                      const CustomText(
                        textAlign: TextAlign.center,
                        AppIngoMsg.locationinfo,
                      ),
                    isFirstTime
                        ? const Spacer()
                        : Column(
                            children: [
                              AppSizedBox.sizedBox5H,
                              const CustomDivider(),
                              AppSizedBox.sizedBox5H,
                            ],
                          ),
                    BlocBuilder<LocationBloc, LocationState>(
                      builder: (context, state) {
                        if (state is LocationLoading) {
                          return CustomAppPadding(
                              padding: AppPadding.onlyBottomMedium,
                              child: const CircularLoading());
                        }
                        return CustomButton(
                            child: CustomText(
                              'Use current location',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            onClick: () {
                              context
                                  .read<LocationBloc>()
                                  .add(LocationCurrentEvent());
                            });
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
