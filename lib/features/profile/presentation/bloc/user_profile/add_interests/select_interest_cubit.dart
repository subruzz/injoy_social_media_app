import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/profile/domain/usecases/profile_usecases/add_interest.dart';

part 'select_interest_state.dart';

class SelectInterestCubit extends Cubit<SelectInterestState> {
  SelectInterestCubit(this._addInterestUseCase)
      : super(SelectInterestInitial());
  final AddInterestUseCase _addInterestUseCase;
  void addInterest(List<String> interest, String uid) async {
    if (interest.isEmpty) {
      emit(SelectInterestEmpty());
      return;
    }
    final res = await _addInterestUseCase(
        AddInterestUseCaseParams(interests: interest, uid: uid));
    res.fold((failure) => emit(SelectInterestFailure()),
        (success) => emit(SelectedInterestsSuccess()));
  }
}
