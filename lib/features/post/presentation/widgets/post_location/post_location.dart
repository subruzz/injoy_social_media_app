import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/features/location/presentation/blocs/location_bloc/location_bloc.dart';

class PostLocation extends StatelessWidget {
  const PostLocation({super.key, required this.locationBloc, this.location});
  final LocationBloc locationBloc;
  final String? location;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: locationBloc,
      builder: (context, state) {
        return ListTile(
          leading: const Icon(Icons.location_on_outlined, color: Colors.white),
          title: Text(
              state is LocationSuccess
                  ? state.locationName
                  : location != null
                      ? location!
                      : 'Location',
              style: TextStyle(
                  color: (state is LocationSuccess || location != null)
                      ? AppDarkColor().secondaryPrimaryText
                      : AppDarkColor().primaryText)),
          trailing: state is LocationLoading
              ? const CircularProgressIndicator()
              : const Icon(Icons.arrow_forward, color: Colors.grey),
          onTap: () {
            locationBloc.add(LocationCurrentEvent());
          },
        );
      },
    );
  }
}
