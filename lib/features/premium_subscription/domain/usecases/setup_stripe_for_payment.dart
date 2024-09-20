import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/premium_subscription/domain/entities/payment_intent_basic.dart';
import 'package:social_media_app/features/premium_subscription/domain/repositories/premium_subscription_repository.dart';

import '../../../../core/common/entities/user_entity.dart';
import '../../../../core/const/enums/location_enum.dart';
import '../../../../core/const/enums/premium_type.dart';

class SetupStripeForPaymentUseCase
    implements UseCase<UserPremium, SetupStripeForPaymentUseCaseParams> {
  final PremiumSubscriptionRepository _premiumSubscriptionRepository;

  SetupStripeForPaymentUseCase(
      {required PremiumSubscriptionRepository premiumSubscriptionRepository})
      : _premiumSubscriptionRepository = premiumSubscriptionRepository;

  @override
  Future<Either<Failure, UserPremium>> call(
      SetupStripeForPaymentUseCaseParams params) async {
    return await _premiumSubscriptionRepository.setUpStripeToCompletePayment(
        paymentIntent: params.paymentIntent, premType: params.premType);
  }
}

class SetupStripeForPaymentUseCaseParams {
  final PaymentIntentBasic paymentIntent;
  final PremiumSubType premType;

  SetupStripeForPaymentUseCaseParams(
      {required this.paymentIntent, required this.premType});
}
