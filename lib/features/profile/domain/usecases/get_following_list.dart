// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/profile/domain/repository/other_user_repository.dart';

class GetFollowingListUseCase
    implements UseCase<List<PartialUser>, GetFollowingListUseCaseParms> {
  final OtherUserRepository _otherUserRepository;

  GetFollowingListUseCase({required OtherUserRepository userProfileRepository})
      : _otherUserRepository = userProfileRepository;
  @override
  Future<Either<Failure, List<PartialUser>>> call(
      GetFollowingListUseCaseParms params) async {
    return await _otherUserRepository.getMyFollowingList(
        params.following, params.myUid);
  }
}

class GetFollowingListUseCaseParms {
  final String myUid;
  List<String> following;
  GetFollowingListUseCaseParms({
    required this.following,
    required this.myUid,
  });
}
