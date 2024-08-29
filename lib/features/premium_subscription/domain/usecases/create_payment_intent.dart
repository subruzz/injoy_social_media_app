import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/premium_subscription/domain/entities/payment_intent_basic.dart';
import 'package:social_media_app/features/premium_subscription/domain/repositories/premium_subscription_repository.dart';

import '../../../../core/const/enums/premium_type.dart';

class CreatePaymentIntentUseCase
    implements UseCase<PaymentIntentBasic, CreatePaymentIntentParams> {
  final PremiumSubscriptionRepository _premiumSubscriptionRepository;

  CreatePaymentIntentUseCase(
      {required PremiumSubscriptionRepository premiumSubscriptionRepository})
      : _premiumSubscriptionRepository = premiumSubscriptionRepository;

  @override
  Future<Either<Failure, PaymentIntentBasic>> call(
      CreatePaymentIntentParams params) async {
    return await _premiumSubscriptionRepository
        .createPaymentIntent(params.premType);
  }
}

class CreatePaymentIntentParams {
  final PremiumSubType premType;

  CreatePaymentIntentParams({required this.premType});
}
