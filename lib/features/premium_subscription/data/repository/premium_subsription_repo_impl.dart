import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/features/premium_subscription/data/datasource/premium_subscription_datasource.dart';
import 'package:social_media_app/features/premium_subscription/domain/entities/payment_intent_basic.dart';
import 'package:social_media_app/features/premium_subscription/domain/repositories/premium_subscription_repository.dart';

import '../../../../core/const/enums/location_enum.dart';

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
  Future<Either<Failure, Unit>> setUpStripeToCompletePayment(
      {required PaymentIntentBasic paymentIntent,
      required PremiumSubType premType}) async {
    try {
      await _premiumSubscriptionDatasource.setUpStripeToCompletePayment(
          premType: premType, paymentIntent: paymentIntent);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }

  @override
  Future<Either<Failure, Unit>> upateUserPremiumStatus(
      {required bool hasPremium,
      required String userId,
      required PremiumSubType premType}) async {
    try {
      await _premiumSubscriptionDatasource.updateUserPremiumStatus(
          hasPremium: hasPremium, userId: userId, premType: premType);
      return right(unit);
    } on MainException catch (e) {
      return left(Failure(e.errorMsg));
    }
  }
}
