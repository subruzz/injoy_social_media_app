part of 'premium_subscription_bloc.dart';

sealed class PremiumSubscriptionState extends Equatable {
  const PremiumSubscriptionState();

  @override
  List<Object?> get props => [];
}

class PremiumSubscriptionInitial extends PremiumSubscriptionState {}

class PremiumSubscriptionLoading extends PremiumSubscriptionState {}

class PremiumSubscriptionCompleted extends PremiumSubscriptionState {}

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