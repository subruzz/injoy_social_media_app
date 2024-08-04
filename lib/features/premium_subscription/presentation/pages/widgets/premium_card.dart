import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/features/premium_subscription/presentation/bloc/premium_subscription_bloc.dart';

import '../../../../../core/const/location_enum.dart';
import '../../../../../core/theme/color/app_colors.dart';

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
                Text(title,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                AppSizedBox.sizedBox10H,
                Text(price,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.yellow)),
                AppSizedBox.sizedBox10H,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: features
                      .map((feature) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 18,
                                ),
                                AppSizedBox.sizedBox10H,
                                Expanded(
                                  child: Text(
                                    feature,
                                    style:  TextStyle(
                                      fontSize: 14.sp,
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
