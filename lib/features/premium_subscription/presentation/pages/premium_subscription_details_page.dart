import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/const/extensions/datetime_to_string.dart';
import 'package:social_media_app/core/const/extensions/localization.dart';
import 'package:social_media_app/core/widgets/app_related/app_custom_appbar.dart';
import 'package:social_media_app/core/widgets/app_related/app_padding.dart';
import 'package:social_media_app/core/widgets/app_related/common_text.dart';

import '../../../../core/const/enums/premium_type.dart';

class PremiumSubscriptionDetailsPage extends StatefulWidget {
  const PremiumSubscriptionDetailsPage({super.key});

  @override
  State<PremiumSubscriptionDetailsPage> createState() =>
      _PremiumSubscriptionDetailsPageState();
}

class _PremiumSubscriptionDetailsPageState
    extends State<PremiumSubscriptionDetailsPage> {
  late final String planName;
  late final DateTime activationDate;
  late final DateTime endDate;
  late AppUser appUser;
  @override
  void initState() {
    super.initState();
     appUser = context.read<AppUserBloc>().appUser;
    activationDate = appUser.userPrem!.purchasedAt.toDate();
    planName = _getPlanName(appUser.userPrem!.premType);
    endDate = _calculateEndDate(
        activationDate, _getPlanDuration(appUser.userPrem!.premType));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppCustomAppbar(
        title: l10n!.your_premium_plan,
        showLeading: true,
      ),
      body: CustomAppPadding(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSizedBox.sizedBox20H,
            Center(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.purple.shade700, Colors.pink.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  'Current Plan: $planName',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
            AppSizedBox.sizedBox40H,
            _buildDetailRow(
                l10n.plan_purchased_on, activationDate.toFormattedDate()),
            AppSizedBox.sizedBox20H,
            _buildDetailRow(l10n.plan_end_on, endDate.toFormattedDate()),
            AppSizedBox.sizedBox20H,
            _buildDetailRow(
              l10n.subscription_status,
              appUser.hasPremium ? 'Active' : 'Inactive',
            ),
          ],
        ),
      ),
    );
  }

  DateTime _calculateEndDate(DateTime startDate, int months) {
    final year = startDate.year;
    final month = startDate.month + months;
    final day = startDate.day;

    final newMonth = (month - 1) % 12 + 1;
    final newYear = year + (month - 1) ~/ 12;

    return DateTime(newYear, newMonth, day);
  }

  int _getPlanDuration(PremiumSubType premType) {
    switch (premType) {
      case PremiumSubType.oneMonth:
        return 1;
      case PremiumSubType.threeMonth:
        return 3;
      case PremiumSubType.oneYear:
        return 12;
      default:
        return 0; // Handle unknown plan types
    }
  }

  String _getPlanName(PremiumSubType premType) {
    switch (premType) {
      case PremiumSubType.oneMonth:
        return "1 Month Plan";
      case PremiumSubType.threeMonth:
        return "3 Months Plan";
      case PremiumSubType.oneYear:
        return "1 Year Plan";
      default:
        return "Unknown Plan"; 
    }
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomText(
            text: label,
            textAlign: TextAlign.start,
          ),
        ),
        AppSizedBox.sizedBox10W,
        Expanded(
          child: CustomText(
            textAlign: TextAlign.start,
            text: value,
          ),
        ),
      ],
    );
  }
}
