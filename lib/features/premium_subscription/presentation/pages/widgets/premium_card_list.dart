import 'package:flutter/material.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/features/premium_subscription/presentation/pages/widgets/premium_card.dart';

import '../../../../../core/const/location_enum.dart';

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
              'Download posts from other users',
              'Edit posts after posting',
            ],
          ),
          const SubscriptionCard(
            premiumSubType: PremiumSubType.threeMonth,
            title: '3 Months',
            price: '₹499/3mo',
            features: [
              'See who visited your profile',
              'Download posts from other users',
              'Edit posts after posting',
            ],
          ),
          const SubscriptionCard(
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
    );
  }
}
