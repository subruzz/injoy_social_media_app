import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/app_error_gif.dart';
import 'package:social_media_app/core/const/app_config/app_border_radius.dart';
import 'package:social_media_app/core/const/app_config/app_padding.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/enums/location_enum.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/utils/debouncer.dart';
import 'package:social_media_app/core/widgets/app_related/app_custom_appbar.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/core/widgets/app_related/empty_display.dart';
import 'package:social_media_app/core/widgets/custom_divider.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/core/widgets/textfields/custom_textform_field.dart';
import 'package:social_media_app/features/location/data/models/location_search_model.dart';
import 'package:social_media_app/features/location/domain/entities/location.dart';
import 'package:social_media_app/features/location/presentation/blocs/location_bloc/location_bloc.dart';
import 'package:social_media_app/features/location/presentation/widgets/location_dialog.dart';
import 'package:social_media_app/features/profile/presentation/bloc/user_profile_bloc/index.dart';

import '../../../../core/widgets/app_related/common_text.dart';
import '../../../../core/widgets/button/custom_elevated_button.dart';

class LocationAskingPage extends StatefulWidget {
  const LocationAskingPage({super.key, required this.isFirstTime});
  final bool isFirstTime;

  @override
  State<LocationAskingPage> createState() => _LocationAskingPageState();
}

class _LocationAskingPageState extends State<LocationAskingPage> {
  void submitProfile(BuildContext context, UserLocation? location) {
    context.read<ProfileBloc>().add(CompleteProfileSetup(
        userName: '',
        location: location,
        uid: context.read<AppUserBloc>().appUser.id));
  }

  final _debouncer = Debouncer(delay: const Duration(milliseconds: 700));
  @override
  Widget build(BuildContext context) {
    final locationBloc = context.read<LocationBloc>();
    return MultiBlocListener(
      listeners: [
        BlocListener<LocationBloc, LocationState>(
          listener: (context, state) {
            if (state is LocationSuccess) {}
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
      child: Scaffold(
        appBar: AppCustomAppbar(
          title: 'Select Location',
          showLeading: true,
        ),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: CustomAppPadding(
            child: Column(
              children: [
                AppSizedBox.sizedBox15H,
                CustomTextField(
                  onChanged: (value) {
                    _debouncer.run(() {
                      locationBloc.add(GetSuggestedLocation(query: value));
                    });
                  },
                  hintText: 'Search manually..',
                  // prefixIcon: Icons.search,
                ),
                AppSizedBox.sizedBox5H,
                const CustomDivider(),
                AppSizedBox.sizedBox5H,
                CustomButton(
                    radius: AppBorderRadius.small,
                    child: CustomText(
                      'Use current location',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    onClick: () {
                      locationBloc.add(LocationCurrentEvent());
                    }),
                AppSizedBox.sizedBox10H,
                BlocConsumer(
                  bloc: locationBloc,
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is LocationFailure) {
                      return const Center(child: AppErrorGif());
                    }

                    if (state is LocationSearchLoaded) {
                      return Expanded(
                        child: ListView.builder(
                          padding: AppPadding.horizontalExtraSmall,
                          itemCount: state.suggestions.length,
                          itemBuilder: (context, index) {
                            final loc = state.suggestions[index];

                            return LocationCard(location: loc);
                          },
                        ),
                      );
                    }
                    if (state is LocationLoading) {
                      return Padding(
                        padding: AppPadding.onlyTopLarge,
                        child: const CircularLoading(),
                      );
                    }
                    return const EmptyDisplay();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LocationCard extends StatelessWidget {
  final SuggestedLocation location;

  const LocationCard({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(
        Icons.location_on,
        color: Colors.blue,
      ),
      title: Text(
        location.properties.name ?? 'Unknown Location',
      ),
      subtitle: Text(
        style: Theme.of(context).textTheme.bodyMedium,
        '${location.properties.state ?? ''} , ${location.properties.country ?? ''}',
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[600]),
      onTap: () {
        Navigator.pop(
            context,
            UserLocation(
                latitude: location.latitude,
                longitude: location.longitude,
                currentLocation:
                    '${location.properties.name ?? 'Unknown Location'},${location.properties.state ?? ''} , ${location.properties.country ?? ''}'));
      },
    );
  }
}
