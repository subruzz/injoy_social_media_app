import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/premium_subscription/domain/entities/payment_intent_basic.dart';
import 'package:social_media_app/features/premium_subscription/domain/repositories/premium_subscription_repository.dart';

class SetupStripeForPaymentUseCase
    implements UseCase<Unit, SetupStripeForPaymentUseCaseParams> {
  final PremiumSubscriptionRepository _premiumSubscriptionRepository;

  SetupStripeForPaymentUseCase(
      {required PremiumSubscriptionRepository premiumSubscriptionRepository})
      : _premiumSubscriptionRepository = premiumSubscriptionRepository;

  @override
  Future<Either<Failure, Unit>> call(
      SetupStripeForPaymentUseCaseParams params) async {
    return await _premiumSubscriptionRepository.setUpStripeToCompletePayment(
        paymentIntent: params.paymentIntent);
  }
}

class SetupStripeForPaymentUseCaseParams {
  final PaymentIntentBasic paymentIntent;

  SetupStripeForPaymentUseCaseParams({required this.paymentIntent});
}
