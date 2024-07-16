import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/features/profile/domain/usecases/follow_user.dart';
import 'package:social_media_app/features/profile/domain/usecases/unfollow_user.dart';
import 'package:equatable/equatable.dart';

part 'followunfollow_state.dart';

class FollowunfollowCubit extends Cubit<FollowunfollowState> {
  final FollowUserUseCase _followUserUseCase;
  final UnfollowUserUseCase _unfollowUserUseCase;
  final AppUserBloc appUserBloc;
  FollowunfollowCubit(
      this._followUserUseCase, this._unfollowUserUseCase, this.appUserBloc)
      : super(FollowunfollowInitial());

  void followUser(String myId, String otherId,) async {
    appUserBloc.appUser.following.add(otherId);
    emit(FollowLoading());

    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction
            .update(FirebaseFirestore.instance.collection('users').doc(myId), {
          'following': FieldValue.arrayUnion([otherId])
        });

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
      appUserBloc.appUser.following.remove(otherId);
      log('Follow operation failed: $e');
      emit(FollowFailure(errorMsg: e.toString()));
    }
  }

  void unfollowUser({required String myId,required String otherId}) async {
    appUserBloc.appUser.following.remove(otherId);
    emit(UnfollowLoading());

    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction
            .update(FirebaseFirestore.instance.collection('users').doc(myId), {
          'following': FieldValue.arrayRemove([otherId])
        });

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
      appUserBloc.appUser.following.add(otherId);
      log('Unfollow operation failed: $e');
      emit(UnfollowFailure(errorMsg: e.toString()));
    }
  }
}
