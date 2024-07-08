import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/features/profile/domain/usecases/get_other_user_details.dart';

part 'other_profile_state.dart';

class OtherProfileCubit extends Cubit<OtherProfileState> {
  final GetOtherUserDetailsUseCase _getOtherUserDetailsUseCase;
  OtherProfileCubit(this._getOtherUserDetailsUseCase)
      : super(OtherProfileInitial());
  void getOtherProfile(String uId) async {
    emit(OtherProfileLoading());
    final res = await _getOtherUserDetailsUseCase(
        GetOtherUserDetailsUseCaseParms(uid: uId));
    res.fold((failure) => emit(OtherProfileError(error: failure.message)),
        (success) => emit(OtherProfileSuccess(userProfile: success)));
  }
}
