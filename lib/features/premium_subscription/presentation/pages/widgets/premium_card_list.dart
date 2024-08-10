import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/features/premium_subscription/presentation/pages/widgets/premium_card.dart';

import '../../../../../core/const/enums/location_enum.dart';

class PremiumCardList extends StatelessWidget {
  const PremiumCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          AppSizedBox.sizedBox20H,
          const SubscriptionCard(
            premiumSubType: PremiumSubType.oneMonth,
            title: '1 Month',
            price: '₹299/mo',
            features: [
              'See who visited your profile',
              'Multi language support',
              'Edit posts after posting',
              'Access to Inaya Ai'
            ],
          ),
          const SubscriptionCard(
            premiumSubType: PremiumSubType.threeMonth,
            title: '3 Months',
            price: '₹499/3mo',
            features: [
              'See who visited your profile',
              'Multi language support',
              'Edit posts after posting',
              'Access to Inaya Ai'
            ],
          ),
          const SubscriptionCard(
            premiumSubType: PremiumSubType.oneYear,
            title: '1 Year',
            price: '₹1599/yr',
            features: [
              'See who visited your profile',
              'Multi language support',
              'Edit posts after posting',
              'Access to Inaya Ai'
            ],
          ),
          AppSizedBox.sizedBox45H,
        ],
      ),
    );
  }
}
