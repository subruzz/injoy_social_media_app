part of 'premium_subscription_bloc.dart';

sealed class PremiumSubscriptionEvent extends Equatable {
  const PremiumSubscriptionEvent();

  @override
  List<Object?> get props => [];
}

class CreatePremiumsubscriptionIntent extends PremiumSubscriptionEvent {
  final String userid;

  const CreatePremiumsubscriptionIntent({required this.userid});
}