import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/premium_subscription/domain/repositories/premium_subscription_repository.dart';

class UpdateUserPremiumStatusUseCase
    implements UseCase<Unit, UpdateUserPremiumStatusUseCaseParams> {
  final PremiumSubscriptionRepository _premiumSubscriptionRepository;

  UpdateUserPremiumStatusUseCase(
      {required PremiumSubscriptionRepository premiumSubscriptionRepository})
      : _premiumSubscriptionRepository = premiumSubscriptionRepository;

  @override
  Future<Either<Failure, Unit>> call(
      UpdateUserPremiumStatusUseCaseParams params) async {
    return await _premiumSubscriptionRepository.upateUserPremiumStatus(
        hasPremium: params.hasPremium, userId: params.userId);
  }
}

class UpdateUserPremiumStatusUseCaseParams {
  final bool hasPremium;
  final String userId;

  UpdateUserPremiumStatusUseCaseParams(
      {required this.hasPremium, required this.userId});
}
