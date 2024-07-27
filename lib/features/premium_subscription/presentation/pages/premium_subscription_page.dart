import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/widgets/loading/circular_loading.dart';
import 'package:social_media_app/features/premium_subscription/presentation/bloc/premium_subscription_bloc.dart';

import '../../../bottom_nav/presentation/pages/bottom_nav.dart';

class PremiumSubscriptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<PremiumSubscriptionBloc, PremiumSubscriptionState>(
          listener: (context, state) {
            if (state is PremiumSubscriptionCompleted) {
          
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => BottonNavWithAnimatedIcons(),
                ),
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Premium',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      '₹299/mo',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const FeatureTile(
                      text: 'See who visited your profile',
                    ),
                    FeatureTile(
                      text: 'Download posts from other users',
                    ),
                    FeatureTile(
                      text: 'Edit posts after posting',
                    ),
                    Spacer(),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<PremiumSubscriptionBloc>().add(
                              CreatePremiumsubscriptionIntent(
                                  userid: context.read<AppUserBloc>().appUser.id));
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Buy now',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (state is PremiumSubscriptionLoading ||
                    state is PremiumSubscriptionIntentSuccess)
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(
                      child: CircularLoadingGrey(),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class FeatureTile extends StatelessWidget {
  final String text;

  const FeatureTile({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 24,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
