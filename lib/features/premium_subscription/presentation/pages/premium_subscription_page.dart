import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
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
            Navigator.pop(context);
          },
        ),
        title: Text('Premium Subscription'),
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
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        'Choose Your Plan',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      Wrap(
                        children: [
                          SubscriptionCard(
                            title: '1 Month',
                            price: '₹299/mo',
                            features: [
                              'See who visited your profile',
                              'Download posts from other users',
                              'Edit posts after posting',
                            ],
                            onPressed: () {
                              context
                                  .read<PremiumSubscriptionBloc>()
                                  .add(CreatePremiumsubscriptionIntent(
                                    userid:
                                        context.read<AppUserBloc>().appUser.id,
                                  ));
                            },
                          ),
                          SubscriptionCard(
                            title: '3 Months',
                            price: '₹499/3mo',
                            features: [
                              'See who visited your profile',
                              'Download posts from other users',
                              'Edit posts after posting',
                            ],
                            onPressed: () {
                              context
                                  .read<PremiumSubscriptionBloc>()
                                  .add(CreatePremiumsubscriptionIntent(
                                    userid:
                                        context.read<AppUserBloc>().appUser.id,
                                  ));
                            },
                          ),
                          SubscriptionCard(
                            title: '1 Year',
                            price: '₹1599/yr',
                            features: [
                              'See who visited your profile',
                              'Download posts from other users',
                              'Edit posts after posting',
                            ],
                            onPressed: () {
                              context
                                  .read<PremiumSubscriptionBloc>()
                                  .add(CreatePremiumsubscriptionIntent(
                                    userid:
                                        context.read<AppUserBloc>().appUser.id,
                                  ));
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
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

class SubscriptionCard extends StatelessWidget {
  final String title;
  final String price;
  final List<String> features;
  final VoidCallback onPressed;

  const SubscriptionCard({
    required this.title,
    required this.price,
    required this.features,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppDarkColor().softBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              price,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.yellow,
              ),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: features
                  .map((feature) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 18,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                feature,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Select',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
