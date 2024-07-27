import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

// const String stripePublishableKey =
//     'pk_test_51Pgpk4Jzuiu6Tez26yOlSy6rECzWks2Yzl1Ql7ImXftPgLnzF0KdyPygTMyYj781jAv6whHUvNGjwkQcGTtIRYMX0011861DQ1';
// const String stripeSecretKey =
//     'sk_test_51Pgpk4Jzuiu6Tez24gZAiS28zGlAcTrmyYJrDWmfWIVP71TdN9UCRMKsaROF82UZn7cFJsZEipGCajSx8Ao9SZ2700Eod0VMRv';

class StripServices {
  StripServices._();

  static final StripServices instance = StripServices._();
  Future<void> makePayment() async {
    try {
      print('called');
      final String? clientSecret =
          await _createPaymentIntent(amount: 100, currency: 'INR');
      if (clientSecret == null) return;
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              style: ThemeMode.dark,
              paymentIntentClientSecret: clientSecret,
              merchantDisplayName: 'Subramanayan'));
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      log("error in payment first ${e.toString()}");
    }
  }

  Future<String?> _createPaymentIntent(
      {required int amount, required String currency}) async {
    try {
      log('this is also called');
      final Uri url = Uri.parse("https://api.stripe.com/v1/payment_intents");
      final body = {
        'amount': calculateAmount(amount),
        'currency': 'INR',
      };
      log('sended ui');
      final stripeSecretKey= dotenv.env['STRIPE_SECRET_KEY']!;
      final response = await http.post(url,
          headers: {
            "Authorization": "Bearer $stripeSecretKey",
            "Content-Type": "application/x-www-form-urlencoded",
          },
          body: body);
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        log(json.toString());
        return json['client_secret'];
      } else {
        log("error in payment");
        return null;
      }
    } catch (e) {
      return null;
      log("error in payment${e.toString()}");
    }
  }

  String calculateAmount(int amount) {
    final calculatedAmount = amount * 100;
    return calculatedAmount.toString();
  }
}
