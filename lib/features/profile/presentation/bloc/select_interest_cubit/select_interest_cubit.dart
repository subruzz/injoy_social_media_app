import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'select_interest_state.dart';

class SelectInterestCubit extends Cubit<SelectInterestState> {
  final Set<String> _selectedInterests = {}; 

  SelectInterestCubit() : super(SelectInterestInitial());

  Set<String> get selectedInterests => _selectedInterests;

  void selectInterst(String value) {
    if (_selectedInterests.contains(value)) {
      _selectedInterests.remove(value);
    } else {
      _selectedInterests.add(value);
    }
    print(_selectedInterests);
    emit(
        SelectedInterestsSuccess(selectedinterst: _selectedInterests.toList()));
  }
}
