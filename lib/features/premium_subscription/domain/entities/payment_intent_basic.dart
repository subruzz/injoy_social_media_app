class PaymentIntentBasic {
  final String paymentIntentClientSecret;
  final String? customerEphemeralKeySecret;
  final String customerId;

  PaymentIntentBasic({
    required this.paymentIntentClientSecret,
    required this.customerEphemeralKeySecret,
    required this.customerId,
  });

  factory PaymentIntentBasic.fromJson(Map<String, dynamic> json) {
    return PaymentIntentBasic(
      paymentIntentClientSecret: json['client_secret'] as String,
      customerEphemeralKeySecret:
          json['customer_ephemeral_key_secret'] as String?,
      customerId: json['id'] as String,
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'payment_intent_client_secret': paymentIntentClientSecret,
  //     'customer_ephemeral_key_secret': customerEphemeralKeySecret,
  //     'customer_id': customerId,
  //   };
  // }
}
