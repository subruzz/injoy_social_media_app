import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'following_state.dart';

class FollowingCubit extends Cubit<FollowingState> {
  FollowingCubit() : super(FollowingInitial());
  List<String> followingList = [];
  void listenToFollowing(String userId) {
    emit(FollowingLoading());

    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('following')
        .snapshots()
        .listen((snapshot) {
      final following = snapshot.docs.map((doc) => doc.id).toList();
      followingList = following;
      log(following.toString());
      emit(FollowingLoaded(following));
    }, onError: (error) {
      emit(FollowingError('Failed to load following list: $error'));
    });
  }
}
