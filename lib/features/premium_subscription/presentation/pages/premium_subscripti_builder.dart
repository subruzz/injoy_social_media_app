import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/premium_subscription/presentation/bloc/premium_subscription_bloc.dart';
import 'package:social_media_app/features/premium_subscription/presentation/pages/premium_subscription_page.dart';
import 'package:social_media_app/init_dependecies.dart';

class PremiumSubscriptiBuilder extends StatelessWidget {
  const PremiumSubscriptiBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<PremiumSubscriptionBloc>(),
      child: const PremiumSubscriptionPage(),
    );
  }
}
