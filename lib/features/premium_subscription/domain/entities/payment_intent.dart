// //not all varialbes are needed
// //this is added for future if we need to add something more
// //currently only be using the --->clientSecret

// class PaymentIntent {
//   final String id;
//   final String object;
//   final int amount;
//   final int amountCapturable;
//   final AmountDetails amountDetails;
//   final int amountReceived;
//   final String? application;
//   final int? applicationFeeAmount;
//   final AutomaticPaymentMethods automaticPaymentMethods;
//   final int? canceledAt;
//   final String? cancellationReason;
//   final String captureMethod;
//   final String clientSecret;
//   final String confirmationMethod;
//   final int created;
//   final String currency;
//   final String? customer;
//   final String? description;
//   final String? invoice;
//   final String? lastPaymentError;
//   final String? latestCharge;
//   final bool livemode;
//   final Map<String, dynamic> metadata;
//   final String? nextAction;
//   final String? onBehalfOf;
//   final String? paymentMethod;
//   final String? paymentMethodConfigurationDetails;
//   final PaymentMethodOptions paymentMethodOptions;
//   final List<String> paymentMethodTypes;
//   final String? processing;
//   final String? receiptEmail;
//   final String? review;
//   final String? setupFutureUsage;
//   final String? shipping;
//   final String? source;
//   final String? statementDescriptor;
//   final String? statementDescriptorSuffix;
//   final String status;
//   final String? transferData;
//   final String? transferGroup;

//   PaymentIntent({
//     required this.id,
//     required this.object,
//     required this.amount,
//     required this.amountCapturable,
//     required this.amountDetails,
//     required this.amountReceived,
//     this.application,
//     this.applicationFeeAmount,
//     required this.automaticPaymentMethods,
//     this.canceledAt,
//     this.cancellationReason,
//     required this.captureMethod,
//     required this.clientSecret,
//     required this.confirmationMethod,
//     required this.created,
//     required this.currency,
//     this.customer,
//     this.description,
//     this.invoice,
//     this.lastPaymentError,
//     this.latestCharge,
//     required this.livemode,
//     required this.metadata,
//     this.nextAction,
//     this.onBehalfOf,
//     this.paymentMethod,
//     this.paymentMethodConfigurationDetails,
//     required this.paymentMethodOptions,
//     required this.paymentMethodTypes,
//     this.processing,
//     this.receiptEmail,
//     this.review,
//     this.setupFutureUsage,
//     this.shipping,
//     this.source,
//     this.statementDescriptor,
//     this.statementDescriptorSuffix,
//     required this.status,
//     this.transferData,
//     this.transferGroup,
//   });

//   factory PaymentIntent.fromJson(Map<String, dynamic> json) {
//     return PaymentIntent(
//       id: json['id'] as String,
//       object: json['object'] as String,
//       amount: json['amount'] as int,
//       amountCapturable: json['amount_capturable'] as int,
//       amountDetails: AmountDetails.fromJson(json['amount_details']),
//       amountReceived: json['amount_received'] as int,
//       application: json['application'] as String?,
//       applicationFeeAmount: json['application_fee_amount'] as int?,
//       automaticPaymentMethods: AutomaticPaymentMethods.fromJson(json['automatic_payment_methods']),
//       canceledAt: json['canceled_at'] as int?,
//       cancellationReason: json['cancellation_reason'] as String?,
//       captureMethod: json['capture_method'] as String,
//       clientSecret: json['client_secret'] as String,
//       confirmationMethod: json['confirmation_method'] as String,
//       created: json['created'] as int,
//       currency: json['currency'] as String,
//       customer: json['customer'] as String?,
//       description: json['description'] as String?,
//       invoice: json['invoice'] as String?,
//       lastPaymentError: json['last_payment_error'] as String?,
//       latestCharge: json['latest_charge'] as String?,
//       livemode: json['livemode'] as bool,
//       metadata: json['metadata'] as Map<String, dynamic>,
//       nextAction: json['next_action'] as String?,
//       onBehalfOf: json['on_behalf_of'] as String?,
//       paymentMethod: json['payment_method'] as String?,
//       paymentMethodConfigurationDetails: json['payment_method_configuration_details'] as String?,
//       paymentMethodOptions: PaymentMethodOptions.fromJson(json['payment_method_options']),
//       paymentMethodTypes: List<String>.from(json['payment_method_types']),
//       processing: json['processing'] as String?,
//       receiptEmail: json['receipt_email'] as String?,
//       review: json['review'] as String?,
//       setupFutureUsage: json['setup_future_usage'] as String?,
//       shipping: json['shipping'] as String?,
//       source: json['source'] as String?,
//       statementDescriptor: json['statement_descriptor'] as String?,
//       statementDescriptorSuffix: json['statement_descriptor_suffix'] as String?,
//       status: json['status'] as String,
//       transferData: json['transfer_data'] as String?,
//       transferGroup: json['transfer_group'] as String?,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'object': object,
//       'amount': amount,
//       'amount_capturable': amountCapturable,
//       'amount_details': amountDetails.toJson(),
//       'amount_received': amountReceived,
//       'application': application,
//       'application_fee_amount': applicationFeeAmount,
//       'automatic_payment_methods': automaticPaymentMethods.toJson(),
//       'canceled_at': canceledAt,
//       'cancellation_reason': cancellationReason,
//       'capture_method': captureMethod,
//       'client_secret': clientSecret,
//       'confirmation_method': confirmationMethod,
//       'created': created,
//       'currency': currency,
//       'customer': customer,
//       'description': description,
//       'invoice': invoice,
//       'last_payment_error': lastPaymentError,
//       'latest_charge': latestCharge,
//       'livemode': livemode,
//       'metadata': metadata,
//       'next_action': nextAction,
//       'on_behalf_of': onBehalfOf,
//       'payment_method': paymentMethod,
//       'payment_method_configuration_details': paymentMethodConfigurationDetails,
//       'payment_method_options': paymentMethodOptions.toJson(),
//       'payment_method_types': paymentMethodTypes,
//       'processing': processing,
//       'receipt_email': receiptEmail,
//       'review': review,
//       'setup_future_usage': setupFutureUsage,
//       'shipping': shipping,
//       'source': source,
//       'statement_descriptor': statementDescriptor,
//       'statement_descriptor_suffix': statementDescriptorSuffix,
//       'status': status,
//       'transfer_data': transferData,
//       'transfer_group': transferGroup,
//     };
//   }
// }

// class AmountDetails {
//   final Map<String, dynamic> tip;

//   AmountDetails({
//     required this.tip,
//   });

//   factory AmountDetails.fromJson(Map<String, dynamic> json) {
//     return AmountDetails(
//       tip: json['tip'] as Map<String, dynamic>,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'tip': tip,
//     };
//   }
// }

// class AutomaticPaymentMethods {
//   final String allowRedirects;
//   final bool enabled;

//   AutomaticPaymentMethods({
//     required this.allowRedirects,
//     required this.enabled,
//   });

//   factory AutomaticPaymentMethods.fromJson(Map<String, dynamic> json) {
//     return AutomaticPaymentMethods(
//       allowRedirects: json['allow_redirects'] as String,
//       enabled: json['enabled'] as bool,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'allow_redirects': allowRedirects,
//       'enabled': enabled,
//     };
//   }
// }

// class PaymentMethodOptions {
//   final Card card;

//   PaymentMethodOptions({
//     required this.card,
//   });

//   factory PaymentMethodOptions.fromJson(Map<String, dynamic> json) {
//     return PaymentMethodOptions(
//       card: Card.fromJson(json['card']),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'card': card.toJson(),
//     };
//   }
// }

// class Card {
//   final String? installments;
//   final String? mandateOptions;
//   final String? network;
//   final String requestThreeDSecure;

//   Card({
//     this.installments,
//     this.mandateOptions,
//     this.network,
//     required this.requestThreeDSecure,
//   });

//   factory Card.fromJson(Map<String, dynamic> json) {
//     return Card(
//       installments: json['installments'] as String?,
//       mandateOptions: json['mandate_options'] as String?,
//       network: json['network'] as String?,
//       requestThreeDSecure: json['request_three_d_secure'] as String,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'installments': installments,
//       'mandate_options': mandateOptions,
//       'network': network,
//       'request_three_d_secure': requestThreeDSecure,
//     };
//   }
// }
