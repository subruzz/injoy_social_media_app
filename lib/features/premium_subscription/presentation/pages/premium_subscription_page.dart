import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/location_enum.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/core/widgets/app_related/app_custom_appbar.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/core/widgets/overlay_loading_holder.dart';
import 'package:social_media_app/features/premium_subscription/presentation/bloc/premium_subscription_bloc.dart';
import '../../../bottom_nav/presentation/pages/bottom_nav.dart';

class PremiumSubscriptionPage extends StatelessWidget {
  const PremiumSubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppCustomAppbar(
        title: 'Choose Your Plan',
        showLeading: true,
      ),
      body: CustomAppPadding(
        child: BlocConsumer<PremiumSubscriptionBloc, PremiumSubscriptionState>(
          listener: (context, state) {
            if (state is PremiumSubscriptionCompleted) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const BottonNavWithAnimatedIcons(),
                ),
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Column(
                  children: [
                    // Text(
                    //   'I N J O Y  PREMIUM',
                    //   style: TextStyle(
                    //     fontSize: 24,
                    //     fontWeight: FontWeight.bold,
                    //     color: Colors.white,
                    //   ),
                    // ),
                    Expanded(
                      child: ListView(
                        physics: AlwaysScrollableScrollPhysics(),
                        children: [
                          SizedBox(height: 20),
                          SubscriptionCard(
                            premiumSubType: PremiumSubType.oneMonth,
                            title: '1 Month',
                            price: '₹299/mo',
                            features: [
                              'See who visited your profile',
                              'Download posts from other users',
                              'Edit posts after posting',
                            ],
                          ),
                          SubscriptionCard(
                            premiumSubType: PremiumSubType.threeMonth,
                            title: '3 Months',
                            price: '₹499/3mo',
                            features: [
                              'See who visited your profile',
                              'Download posts from other users',
                              'Edit posts after posting',
                            ],
                          ),
                          SubscriptionCard(
                            premiumSubType: PremiumSubType.oneYear,
                            title: '1 Year',
                            price: '₹1599/yr',
                            features: [
                              'See who visited your profile',
                              'Download posts from other users',
                              'Edit posts after posting',
                            ],
                          ),
                          AppSizedBox.sizedBox45H,
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<PremiumSubscriptionBloc>().add(
                            CreatePremiumsubscriptionIntent(
                              userid: context.read<AppUserBloc>().appUser.id,
                            ),
                          );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      'Confirm Selection',
                      style: TextStyle(
                        color: Colors.white, // Set button text color here
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                if (state is PremiumSubscriptionLoading)
                  const OverlayLoadingHolder(),
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
  final PremiumSubType premiumSubType;

  const SubscriptionCard({
    super.key,
    required this.premiumSubType,
    required this.title,
    required this.price,
    required this.features,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PremiumSubscriptionBloc, PremiumSubscriptionState>(
      buildWhen: (previous, current) => current is PremiumOptionSelected,
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            context
                .read<PremiumSubscriptionBloc>()
                .add(SelectPremiumOption(premiumSubType: premiumSubType));
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            decoration: BoxDecoration(
              border: Border.all(
                color: state is PremiumOptionSelected &&
                        state.premiumSubType == premiumSubType
                    ? Colors.yellow
                    : Colors.transparent,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(15),
              color: AppDarkColor().secondaryBackground,
            ),
            margin: const EdgeInsets.symmetric(vertical: 8.0),
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
              ],
            ),
          ),
        );
      },
    );
  }
}
