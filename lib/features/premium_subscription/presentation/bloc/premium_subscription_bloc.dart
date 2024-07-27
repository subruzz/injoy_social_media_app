import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/premium_subscription/domain/entities/payment_intent_basic.dart';
import 'package:social_media_app/features/premium_subscription/domain/usecases/create_payment_intent.dart';
import 'package:social_media_app/features/premium_subscription/domain/usecases/setup_stripe_for_payment.dart';

part 'premium_subscription_event.dart';
part 'premium_subscription_state.dart';

class PremiumSubscriptionBloc
    extends Bloc<PremiumSubscriptionEvent, PremiumSubscriptionState> {
  final CreatePaymentIntentUseCase _createPaymentIntentUseCase;
  final SetupStripeForPaymentUseCase _setupStripeForPaymentUseCase;
  PremiumSubscriptionBloc(
      this._createPaymentIntentUseCase, this._setupStripeForPaymentUseCase)
      : super(PremiumSubscriptionInitial()) {
    on<PremiumSubscriptionEvent>((event, emit) {
      emit(PremiumSubscriptionLoading());
    });
    on<CreatePremiumsubscriptionIntent>(_createPremiumsubscriptionIntent);
  }

  FutureOr<void> _createPremiumsubscriptionIntent(
      CreatePremiumsubscriptionIntent event,
      Emitter<PremiumSubscriptionState> emit) async {
    final res = await _createPaymentIntentUseCase(NoParams());
    res.fold((failure) {
      log(failure.message);
      return emit(PremiumSubscriptionFailure(failure.message));
    }, (success)  {
      emit(PremiumSubscriptionIntentSuccess(success));
    });
    if (state is PremiumSubscriptionIntentSuccess) {
      final success = state as PremiumSubscriptionIntentSuccess;
      final stripeRes = await _setupStripeForPaymentUseCase(
          SetupStripeForPaymentUseCaseParams(
              paymentIntent: success.paymentIntent));
      stripeRes.fold(
          (failure) => emit(PremiumSubscriptionFailure(failure.message)),
          (success) => emit(PremiumSubscriptionCompleted()));
    }
  }
}
