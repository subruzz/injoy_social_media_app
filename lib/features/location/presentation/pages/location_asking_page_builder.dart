import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/location/presentation/blocs/location_bloc/location_bloc.dart';
import 'package:social_media_app/features/location/presentation/pages/location_asking_page.dart';

import '../../../../core/utils/di/di.dart';

class LocationAskingPageBuilder extends StatelessWidget {
  const LocationAskingPageBuilder({super.key, this.isFirstTime = false});
  final bool isFirstTime;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => serviceLocator<LocationBloc>(),
        child: LocationAskingPage(
          isFirstTime: isFirstTime,
        ));
  }
}
