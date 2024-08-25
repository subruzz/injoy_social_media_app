import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_bar_state.dart';

class BottomBarCubit extends Cubit<BottomBarState> {
  BottomBarCubit() : super(const BottomBarState(index: 0));
  void changeIndex(int index) {
    emit(state.copyWith(index: index));
  }

  void changePoppingBehavOfExplore(bool val) {
    state.copyWith(canPopFromTheExplore: val);
  }
}
