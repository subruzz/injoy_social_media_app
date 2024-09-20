import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/utils/errors/exception.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/features/premium_subscription/data/datasource/premium_subscription_datasource.dart';
import 'package:social_media_app/features/premium_subscription/domain/entities/payment_intent_basic.dart';
import 'package:social_media_app/features/premium_subscription/domain/repositories/premium_subscription_repository.dart';

import '../../../../core/common/entities/user_entity.dart';
import '../../../../core/const/enums/location_enum.dart';
import '../../../../core/const/enums/premium_type.dart';

class PremiumSubsriptionRepoImpl implements PremiumSubscriptionRepository {
  final PremiumSubscriptionDatasource _premiumSubscriptionDatasource;

  PremiumSubsriptionRepoImpl(
      {required PremiumSubscriptionDatasource premiumSubscriptionDatasource})
      : _premiumSubscriptionDatasource = premiumSubscriptionDatasource;
  @override
  Future<Either<Failure, PaymentIntentBasic>> createPaymentIntent(
      PremiumSubType premType) async {
    try {
      final res =
          await _premiumSubscriptionDatasource.createPaymentIntent(premType);

      return right(res);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    } catch (e) {
      log(e.toString());

      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserPremium>> setUpStripeToCompletePayment(
      {required PaymentIntentBasic paymentIntent,
      required PremiumSubType premType}) async {
    try {
      final res =
          await _premiumSubscriptionDatasource.setUpStripeToCompletePayment(
              premType: premType, paymentIntent: paymentIntent);
      return right(res);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }

  @override
  Future<Either<Failure, UserPremium>> upateUserPremiumStatus(
      {required bool hasPremium,
      required String userId,
      required PremiumSubType premType}) async {
    try {
      final res = await _premiumSubscriptionDatasource.updateUserPremiumStatus(
          hasPremium: hasPremium, userId: userId, premType: premType);
      return right(res);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }
}
