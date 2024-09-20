// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/utils/errors/failure.dart';
import 'package:social_media_app/core/common/usecases/usecase.dart';
import 'package:social_media_app/features/profile/domain/repository/user_dat_repository.dart';

class GetFollowersListUseCase
    implements UseCase<List<PartialUser>, GetFollowersListUseCaseParms> {
  final UserDatRepository _userDatRepository;

  GetFollowersListUseCase({required UserDatRepository userDatRepository})
      : _userDatRepository = userDatRepository;
  @override
  Future<Either<Failure, List<PartialUser>>> call(
      GetFollowersListUseCaseParms params) async {
    return await _userDatRepository.getMyFollowersList(params.myUid);
  }
}

class GetFollowersListUseCaseParms {
  final String myUid;
  GetFollowersListUseCaseParms({
    required this.myUid,
  });
}
