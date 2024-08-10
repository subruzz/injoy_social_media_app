import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';

import '../../../../../core/const/enums/location_enum.dart';
import '../../../../../core/widgets/button/custom_elevated_button.dart';
import '../../bloc/premium_subscription_bloc.dart';

class PremiumBuyButton extends StatelessWidget {
  const PremiumBuyButton({super.key});
  String _getPriceText(PremiumSubType type) {
    switch (type) {
      case PremiumSubType.oneMonth:
        return '₹299/mo';
      case PremiumSubType.threeMonth:
        return '₹499/3mo';
      case PremiumSubType.oneYear:
        return '₹1599/yr';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PremiumSubscriptionBloc, PremiumSubscriptionState>(
      buildWhen: (previous, current) => current is PremiumOptionSelected,
      builder: (context, premTypeState) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: CustomButton(
            child: Text(
              'Continue with ${premTypeState is PremiumOptionSelected ? _getPriceText(premTypeState.premiumSubType) : ''}',
            ),
            onClick: () {
              if (premTypeState is PremiumOptionSelected) {
                context.read<PremiumSubscriptionBloc>().add(
                      CreatePremiumsubscriptionIntent(
                        premiumSubType: premTypeState.premiumSubType,
                        userid: context.read<AppUserBloc>().appUser.id,
                      ),
                    );
              } else {
                // Handle case where premiumSubType is not selected, if necessary
              }
            },
          ),
        );
      },
    );
  }
}
