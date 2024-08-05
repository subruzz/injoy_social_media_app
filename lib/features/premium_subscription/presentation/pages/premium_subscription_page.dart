import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/widgets/app_related/app_custom_appbar.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/core/widgets/overlay_loading_holder.dart';
import 'package:social_media_app/features/premium_subscription/presentation/bloc/premium_subscription_bloc.dart';
import 'package:social_media_app/features/premium_subscription/presentation/pages/widgets/premium_buy_button.dart';
import 'package:social_media_app/features/premium_subscription/presentation/pages/widgets/premium_card_list.dart';
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
              context.read<AppUserBloc>().appUser.hasPremium = true;
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
                const Column(
                  children: [
                    PremiumCardList()
                    // Text(
                    //   'I N J O Y  PREMIUM',
                    //   style: TextStyle(
                    //     fontSize: 24,
                    //     fontWeight: FontWeight.bold,
                    //     color: Colors.white,
                    //   ),
                    // ),
                  ],
                ),
                const PremiumBuyButton(),
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
