import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/premium_subscription/domain/entities/payment_intent_basic.dart';

abstract interface class PremiumSubscriptionRepository {
  Future<Either<Failure, PaymentIntentBasic>> createPaymentIntent();
  Future<Either<Failure, Unit>> setUpStripeToCompletePayment(
      {required PaymentIntentBasic paymentIntent});
  Future<Either<Failure, Unit>> upateUserPremiumStatus(
      {required bool hasPremium,required String userId});
}
