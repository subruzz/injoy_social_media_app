import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/premium_subscription/domain/repositories/premium_subscription_repository.dart';

import '../../../../core/common/entities/user_entity.dart';
import '../../../../core/const/enums/premium_type.dart';

class UpdateUserPremiumStatusUseCase
    implements UseCase<UserPremium, UpdateUserPremiumStatusUseCaseParams> {
  final PremiumSubscriptionRepository _premiumSubscriptionRepository;

  UpdateUserPremiumStatusUseCase(
      {required PremiumSubscriptionRepository premiumSubscriptionRepository})
      : _premiumSubscriptionRepository = premiumSubscriptionRepository;

  @override
  Future<Either<Failure, UserPremium>> call(
      UpdateUserPremiumStatusUseCaseParams params) async {
    return await _premiumSubscriptionRepository.upateUserPremiumStatus(
        hasPremium: params.hasPremium,
        userId: params.userId,
        premType: params.premType);
  }
}

class UpdateUserPremiumStatusUseCaseParams {
  final bool hasPremium;
  final String userId;
  final PremiumSubType premType;

  UpdateUserPremiumStatusUseCaseParams(
      {required this.hasPremium, required this.userId, required this.premType});
}
