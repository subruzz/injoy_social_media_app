import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(const BottomNavState(0));

  void changePage(int index) {
    emit(BottomNavState(index));
    print(state.index);
    //   if (index == 0) {
    //     emit(HomePageState());
    //   } else if (index == 1) {
    //     emit(ExplorePageState());
    //   } else if (index == 2) {
    //     emit(MesssagePageState());
    //   } else if (index == 3) {
    //     emit(NotificationPageState());
    //   } else if (index == 4) {
    //     emit(ProfilePageState());
    //   }
    // }
  }
}
