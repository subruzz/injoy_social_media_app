import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/profile/domain/usecases/follow_user.dart';
import 'package:social_media_app/features/profile/domain/usecases/unfollow_user.dart';
import 'package:equatable/equatable.dart';

part 'followunfollow_state.dart';

class FollowunfollowCubit extends Cubit<FollowunfollowState> {
  final FollowUserUseCase _followUserUseCase;
  final UnfollowUserUseCase _unfollowUserUseCase;

  FollowunfollowCubit(this._followUserUseCase, this._unfollowUserUseCase)
      : super(FollowunfollowInitial());

  void followUser(String myId, String otherId, List<String> following) async {
    following.add(otherId);
    emit(FollowLoading());

    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(
          FirebaseFirestore.instance
              .collection('users')
              .doc(myId)
              .collection('following')
              .doc(otherId),
          {'timestamp': FieldValue.serverTimestamp()},
        );

        transaction.set(
          FirebaseFirestore.instance
              .collection('users')
              .doc(otherId)
              .collection('followers')
              .doc(myId),
          {'timestamp': FieldValue.serverTimestamp()},
        );

        transaction.update(
          FirebaseFirestore.instance.collection('users').doc(myId),
          {'followingCount': FieldValue.increment(1)},
        );

        transaction.update(
          FirebaseFirestore.instance.collection('users').doc(otherId),
          {'followersCount': FieldValue.increment(1)},
        );
      });

      emit(FollowSuccess());
    } catch (e) {
      following.remove(otherId);
      log('Follow operation failed: $e');
      emit(FollowFailure(errorMsg: e.toString()));
    }
  }

  void unfollowUser(String myId, String otherId, List<String> following) async {
    following.remove(otherId);
    emit(UnfollowLoading());

    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.delete(
          FirebaseFirestore.instance
              .collection('users')
              .doc(myId)
              .collection('following')
              .doc(otherId),
        );

        transaction.delete(
          FirebaseFirestore.instance
              .collection('users')
              .doc(otherId)
              .collection('followers')
              .doc(myId),
        );

        transaction.update(
          FirebaseFirestore.instance.collection('users').doc(myId),
          {'followingCount': FieldValue.increment(-1)},
        );

        transaction.update(
          FirebaseFirestore.instance.collection('users').doc(otherId),
          {'followersCount': FieldValue.increment(-1)},
        );
      });

      emit(UnfollowSuccess());
    } catch (e) {
      following.add(otherId);
      log('Unfollow operation failed: $e');
      emit(UnfollowFailure(errorMsg: e.toString()));
    }
  }
}
