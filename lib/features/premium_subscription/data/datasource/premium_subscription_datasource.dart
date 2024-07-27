import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:social_media_app/core/const/fireabase_const/firebase_collection.dart';
import 'package:social_media_app/core/errors/exception.dart';
import 'package:social_media_app/features/premium_subscription/domain/entities/payment_intent_basic.dart';
import 'package:http/http.dart' as http;

abstract interface class PremiumSubscriptionDatasource {
  Future<PaymentIntentBasic> createPaymentIntent();
  Future<void> setUpStripeToCompletePayment(
      {required PaymentIntentBasic paymentIntent});
  Future<void> updateUserPremiumStatus(
      {required bool hasPremium, required String userId});
}

class PremiumSubscriptionDatasourceImpl
    implements PremiumSubscriptionDatasource {
  final stripePaymentEndPoint = "https://api.stripe.com/v1/payment_intents";

  @override
  Future<PaymentIntentBasic> createPaymentIntent() async {
    try {
      final Uri url = Uri.parse(stripePaymentEndPoint);
      final body = {
        'amount': calculateAmount(299),
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
      throw const MainException();
    } catch (e) {
      log(e.toString());
      throw const MainException();
    }
  }

  String calculateAmount(int amount) {
    final calculatedAmount = amount * 100;
    return calculatedAmount.toString();
  }

  @override
  Future<void> setUpStripeToCompletePayment(
      {required PaymentIntentBasic paymentIntent}) async {
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
      updateUserPremiumStatus(hasPremium: true, userId: userId);
    } catch (e) {
      log('stripe error ${e.toString()}');
      throw const MainException(errorMsg: 'Payment failed,Please try again!');
    }
  }

  @override
  Future<void> updateUserPremiumStatus(
      {required bool hasPremium, required String userId}) async {
    final userRef =
        FirebaseFirestore.instance.collection(FirebaseCollectionConst.users);
    try {
      userRef.doc(userId).update({'hasPremium': hasPremium});
    } catch (e) {
      throw const MainException(errorMsg: 'Payment failed,Please try again!');
    }
  }
}
