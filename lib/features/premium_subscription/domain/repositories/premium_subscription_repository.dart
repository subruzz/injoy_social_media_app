import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/const/enums/premium_type.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/premium_subscription/domain/entities/payment_intent_basic.dart';

import '../../../../core/const/enums/location_enum.dart';

abstract interface class PremiumSubscriptionRepository {
  Future<Either<Failure, PaymentIntentBasic>> createPaymentIntent(
      PremiumSubType premType);
  Future<Either<Failure, UserPremium>> setUpStripeToCompletePayment(
      {required PaymentIntentBasic paymentIntent,
      required PremiumSubType premType});
  Future<Either<Failure, UserPremium>> upateUserPremiumStatus(
      {required bool hasPremium,
      required String userId,
      required PremiumSubType premType});
}
