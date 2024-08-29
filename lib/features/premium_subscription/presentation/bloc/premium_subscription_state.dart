part of 'premium_subscription_bloc.dart';

sealed class PremiumSubscriptionState extends Equatable {
  const PremiumSubscriptionState();

  @override
  List<Object?> get props => [];
}

class PremiumSubscriptionInitial extends PremiumSubscriptionState {}

class PremiumSubscriptionLoading extends PremiumSubscriptionState {}

class PremiumSubscriptionCompleted extends PremiumSubscriptionState {
  final UserPremium userPremium;

  const PremiumSubscriptionCompleted({required this.userPremium});
}

class PremiumSubscriptionIntentSuccess extends PremiumSubscriptionState {
  final PaymentIntentBasic paymentIntent;

  const PremiumSubscriptionIntentSuccess(this.paymentIntent);

  @override
  List<Object?> get props => [paymentIntent];
}

class PremiumSubscriptionFailure extends PremiumSubscriptionState {
  final String error;

  const PremiumSubscriptionFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class PremiumOptionSelected extends PremiumSubscriptionState {
  final PremiumSubType premiumSubType;

  const PremiumOptionSelected({required this.premiumSubType});
}
