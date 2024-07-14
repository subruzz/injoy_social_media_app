import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'follow_hashtag_state.dart';
class FollowHashtagCubit extends Cubit<FollowHashtagState> {
  final FirebaseFirestore _firebaseFirestore;
  final String userId;

  FollowHashtagCubit(this._firebaseFirestore, this.userId) : super(FollowHashtagInitial());

  Future<void> followHashtag(String hashtag) async {
    emit(FollowHashtagLoading());
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('followedHashtags')
          .doc(hashtag)
          .set({'hashtag': hashtag});
      emit(FollowHashtagSuccess());
    } catch (e) {
      emit(FollowHashtagFailure(error: e.toString()));
    }
  }

  Future<void> unfollowHashtag(String hashtag) async {
    emit(FollowHashtagLoading());
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('followedHashtags')
          .doc(hashtag)
          .delete();
      emit(FollowHashtagSuccess());
    } catch (e) {
      emit(FollowHashtagFailure(error: e.toString()));
    }
  }

  Future<void> checkIfFollowing(String hashtag) async {
    emit(FollowHashtagLoading());
    try {
      final doc = await _firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('followedHashtags')
          .doc(hashtag)
          .get();
      if (doc.exists) {
        emit(FollowHashtagFollowing());
      } else {
        emit(FollowHashtagNotFollowing());
      }
    } catch (e) {
      emit(FollowHashtagFailure(error: e.toString()));
    }
  }
}
