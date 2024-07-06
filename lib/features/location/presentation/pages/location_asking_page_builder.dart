import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:social_media_app/features/location/domain/usecases/get_location.dart';
import 'package:social_media_app/features/location/presentation/blocs/location_bloc/location_bloc.dart';
import 'package:social_media_app/features/location/presentation/pages/location_asking_page.dart';

class LocationAskingPageBuilder extends StatelessWidget {
  const LocationAskingPageBuilder({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => LocationBloc(GetIt.instance<GetLocationUseCase>()),
        child: const LocationAskingPage());
  }
}
