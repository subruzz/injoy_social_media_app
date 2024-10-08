part of 'premium_subscription_bloc.dart';

sealed class PremiumSubscriptionEvent extends Equatable {
  const PremiumSubscriptionEvent();

  @override
  List<Object?> get props => [];
}

class CreatePremiumsubscriptionIntent extends PremiumSubscriptionEvent {
  final String userid;
  final PremiumSubType premiumSubType;

  const CreatePremiumsubscriptionIntent({
    required this.userid,
    required this.premiumSubType,
  });
}

class SelectPremiumOption extends PremiumSubscriptionEvent {
  final PremiumSubType premiumSubType;

  const SelectPremiumOption({required this.premiumSubType});
}
