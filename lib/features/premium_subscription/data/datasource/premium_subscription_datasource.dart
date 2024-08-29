import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/const/fireabase_const/firebase_collection.dart';
import 'package:social_media_app/core/const/enums/location_enum.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/features/premium_subscription/domain/entities/payment_intent_basic.dart';
import 'package:http/http.dart' as http;

import '../../../../core/const/enums/premium_type.dart';

abstract interface class PremiumSubscriptionDatasource {
  Future<PaymentIntentBasic> createPaymentIntent(PremiumSubType premType);
  Future<UserPremium> setUpStripeToCompletePayment(
      {required PaymentIntentBasic paymentIntent,
      required PremiumSubType premType});
  Future<UserPremium> updateUserPremiumStatus(
      {required bool hasPremium,
      required String userId,
      required PremiumSubType premType});
}

class PremiumSubscriptionDatasourceImpl
    implements PremiumSubscriptionDatasource {
  final stripePaymentEndPoint = "https://api.stripe.com/v1/payment_intents";

  @override
  Future<PaymentIntentBasic> createPaymentIntent(
      PremiumSubType premType) async {
    log(premType.toString());
    String amount = getAmount(premType);

    try {
      final Uri url = Uri.parse(stripePaymentEndPoint);
      final body = {
        'amount': amount,
        'currency': 'INR',
      };
      final stripeSecretKey = dotenv.env['STRIPE_SECRET_KEY']!;
      final response = await http.post(url,
          headers: {
            "Authorization": "Bearer $stripeSecretKey",
            "Content-Type": "application/x-www-form-urlencoded",
          },
          body: body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var json = jsonDecode(response.body);
        log(jsonEncode(json));
        if (json['id'] == null || json['client_secret'] == null) {
          throw const MainException();
        }
        return PaymentIntentBasic.fromJson(json);
      } else {
        throw const MainException();
      }
    } on StripeConfigException catch (e) {
      log(e.toString());
      throw const MainException();
    } catch (e) {
      log(e.toString());
      throw const MainException();
    }
  }

  String getAmount(PremiumSubType type) {
    int amount = 0;
    switch (type) {
      case PremiumSubType.oneMonth:
        amount = 299;
        break;
      case PremiumSubType.threeMonth:
        amount = 499;
        break;
      case PremiumSubType.oneYear:
        amount = 1599;
        break;
    }
    return calculateAmount(amount);
  }

  String calculateAmount(int amount) {
    final calculatedAmount = amount * 100;
    return calculatedAmount.toString();
  }

  @override
  Future<UserPremium> setUpStripeToCompletePayment(
      {required PaymentIntentBasic paymentIntent,
      required PremiumSubType premType}) async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        throw const MainException(errorMsg: 'Payment failed,Please try again!');
      }
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              style: ThemeMode.dark,
              customerId: paymentIntent.customerId,
              paymentIntentClientSecret:
                  paymentIntent.paymentIntentClientSecret,
              merchantDisplayName: 'I N J O Y PREMIUM'));
      await Stripe.instance.presentPaymentSheet();
      return await updateUserPremiumStatus(
          hasPremium: true, userId: userId, premType: premType);
    } catch (e) {
      log('stripe error ${e.toString()}');
      throw const MainException(errorMsg: 'Payment failed,Please try again!');
    }
  }

  @override
  Future<UserPremium> updateUserPremiumStatus({
    required bool hasPremium,
    required String userId,
    required PremiumSubType premType,
  }) async {
    final userRef = FirebaseFirestore.instance.collection('users');
    try {
      final userPremModel =
          UserPremium(premType: premType, purchasedAt: Timestamp.now());
      await userRef.doc(userId).update(
          {'hasPremium': hasPremium, 'userPremium': userPremModel.toJson()});
      return userPremModel;
    } catch (e) {
      throw const MainException(errorMsg: 'Payment failed, Please try again!');
    }
  }
}
