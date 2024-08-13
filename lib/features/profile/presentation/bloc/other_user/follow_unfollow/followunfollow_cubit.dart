// import 'dart:developer';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:social_media_app/core/common/entities/user_entity.dart';
// import 'package:social_media_app/core/shared_providers/blocs/app_user/app_user_bloc.dart';
// import 'package:social_media_app/features/notification/domain/entities/custon_notifcation.dart';
// import 'package:social_media_app/features/notification/presentation/pages/notification_cubit/notification_cubit.dart';
// import 'package:equatable/equatable.dart';
// import 'package:social_media_app/features/profile/domain/usecases/follow_user.dart';
// import 'package:social_media_app/features/profile/domain/usecases/unfollow_user.dart';

// part 'followunfollow_state.dart';

// class FollowunfollowCubit extends Cubit<FollowunfollowState> {
//   final FollowUserUseCase _followUserUseCase;
//   final UnfollowUserUseCase _unfollowUserUseCase;
//   final NotificationCubit _notificationCubit;
//   final AppUserBloc appUserBloc;

//   // Set to track ongoing actions by user ID
//   final Set<String> _ongoingActions = {};

//   FollowunfollowCubit(this._followUserUseCase, this._unfollowUserUseCase,
//       this.appUserBloc, this._notificationCubit)
//       : super(FollowunfollowInitial());

//   void followUnfollowAction({
//     required String myid,
//     required String otherId,
//     required AppUser user,
//     required bool isFollowing,
//   }) async {
//     log('Action: ${isFollowing ? 'Follow' : 'Unfollow'} for user: $otherId');

//     // If an action for this user is already ongoing, ignore the new request
//     if (_ongoingActions.contains(otherId)) {
//       log('Ongoing action detected for user: $otherId');
//       return;
//     }

//     // Add the action to the ongoing set
//     _ongoingActions.add(otherId);

//     emit(FollowUnfollowStarted());
//     emit(FollowLoading());

//     try {
//       if (isFollowing) {
//         await unfollowUser(myid: myid, otherId: otherId);
//       } else {
//         await followUser(myid, otherId, user);
//       }
//     } finally {
//       // Remove the action from the ongoing set after processing
//       _ongoingActions.remove(otherId);
//     }
//   }

//   Future<void> followUser(String myid, String otherId, AppUser user) async {
//     log('Following user: $otherId');

//     try {
//       await FirebaseFirestore.instance.runTransaction((transaction) async {
//         transaction.update(
//           FirebaseFirestore.instance.collection('users').doc(myid),
//           {
//             'following': FieldValue.arrayUnion([otherId])
//           },
//         );

//         transaction.set(
//           FirebaseFirestore.instance
//               .collection('users')
//               .doc(otherId)
//               .collection('followers')
//               .doc(myid),
//           {'timestamp': FieldValue.serverTimestamp()},
//         );

//         transaction.update(
//           FirebaseFirestore.instance.collection('users').doc(myid),
//           {'followingCount': FieldValue.increment(1)},
//         );

//         transaction.update(
//           FirebaseFirestore.instance.collection('users').doc(otherId),
//           {'followersCount': FieldValue.increment(1)},
//         );
//       });

//       _notificationCubit.createNotification(
//         notification: CustomNotification(
//           text: "started following you.",
//           time: Timestamp.now(),
//           senderId: user.id,
//           uniqueId: otherId,
//           receiverId: otherId,
//           isThatLike: false,
//           isThatPost: false,
//           personalUserName: user.userName ?? '',
//           personalProfileImageUrl: user.profilePic,
//           notificationType: NotificationType.profile,
//           senderName: user.userName ?? '',
//         ),
//       );

//       emit(FollowSuccess());
//     } catch (e) {
//       log('Follow operation failed: $e');
//       emit(FollowFailure(errorMsg: e.toString()));
//     }
//   }

//   Future<void> unfollowUser({
//     required String myid,
//     required String otherId,
//   }) async {
//     log('Unfollowing user: $otherId');

//     try {
//       await FirebaseFirestore.instance.runTransaction((transaction) async {
//         transaction.update(
//           FirebaseFirestore.instance.collection('users').doc(myid),
//           {
//             'following': FieldValue.arrayRemove([otherId])
//           },
//         );

//         transaction.delete(
//           FirebaseFirestore.instance
//               .collection('users')
//               .doc(otherId)
//               .collection('followers')
//               .doc(myid),
//         );

//         transaction.update(
//           FirebaseFirestore.instance.collection('users').doc(myid),
//           {'followingCount': FieldValue.increment(-1)},
//         );

//         transaction.update(
//           FirebaseFirestore.instance.collection('users').doc(otherId),
//           {'followersCount': FieldValue.increment(-1)},
//         );
//       });

//       _notificationCubit.deleteNotification(
//         notificationCheck: NotificationCheck(
//           receiverId: otherId,
//           senderId: myid,
//           uniqueId: otherId,
//           notificationType: NotificationType.profile,
//           isThatLike: false,
//           isThatPost: false,
//         ),
//       );

//       emit(UnfollowSuccess());
//     } catch (e) {
//       log('Unfollow operation failed: $e');
//       emit(UnfollowFailure(errorMsg: e.toString()));
//     }
//   }
// }
import 'dart:async';
import 'dart:developer';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/common/shared_providers/blocs/app_user/app_user_bloc.dart';
import 'package:social_media_app/core/utils/other/id_generator.dart';
import 'package:social_media_app/features/notification/domain/entities/customnotifcation.dart';
import 'package:social_media_app/features/notification/presentation/pages/cubit/notification_cubit/notification_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media_app/features/profile/domain/usecases/other_user/follow_user.dart';
import 'package:social_media_app/features/profile/domain/usecases/other_user/unfollow_user.dart';
import 'package:social_media_app/features/settings/domain/entity/ui_entity/enums.dart';

part 'followunfollow_state.dart';

class FollowunfollowCubit extends Cubit<FollowunfollowState> {
  final FollowUserUseCase _followUserUseCase;
  final UnfollowUserUseCase _unfollowUserUseCase;
  final NotificationCubit _notificationCubit;
  final AppUserBloc appUserBloc;

  // Map to store debouncers for each user
  final Map<String, Debouncer> _debouncers = {};

  FollowunfollowCubit(
    this._followUserUseCase,
    this._unfollowUserUseCase,
    this.appUserBloc,
    this._notificationCubit,
  ) : super(FollowunfollowInitial());

  void followUnfollowAction({
    required String myid,
    required String otherId,
    required AppUser user,
    required bool isFollowing,
  }) async {
    emit(FollowUnfollowStarted());

    if (!_debouncers.containsKey(otherId)) {
      _debouncers[otherId] =
          Debouncer(delay: const Duration(milliseconds: 700));
    }
    emit(FollowLoading());
    final debouncer = _debouncers[otherId]!;

    if (isFollowing) {
      log('debouncer is running: ${debouncer.isRunning()}');
      if (debouncer.isRunning()) {
        debouncer.cancel();
        return;
      }
      debouncer.run(() async {
        await unfollowUser(myid: myid, otherId: otherId);
      });
    } else {
      log('debouncer is running: ${debouncer.isRunning()}');
      if (debouncer.isRunning()) {
        debouncer.cancel();
        return;
      }
      debouncer.run(() async {
        await followUser(myid, otherId, user);
      });
    }
  }

  Future<void> followUser(String myid, String otherId, AppUser user) async {
    log('Following user: $otherId');
    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.update(
          FirebaseFirestore.instance.collection('users').doc(myid),
          {
            'following': FieldValue.arrayUnion([otherId])
          },
        );

        transaction.set(
          FirebaseFirestore.instance
              .collection('users')
              .doc(otherId)
              .collection('followers')
              .doc(myid),
          {'timestamp': FieldValue.serverTimestamp()},
        );

        transaction.update(
          FirebaseFirestore.instance.collection('users').doc(myid),
          {'followingCount': FieldValue.increment(1)},
        );

        transaction.update(
          FirebaseFirestore.instance.collection('users').doc(otherId),
          {'followersCount': FieldValue.increment(1)},
        );
      });

      _notificationCubit.createNotification(
        notificationPreferenceType: NotificationPreferenceEnum.follow,
        notification: CustomNotification(
          notificationId: IdGenerator.generateUniqueId(),
          text: "started following you.",
          time: Timestamp.now(),
          senderId: user.id,
          uniqueId: otherId,
          receiverId: otherId,
          isThatLike: false,
          isThatPost: false,
          personalUserName: user.userName ?? '',
          personalProfileImageUrl: user.profilePic,
          notificationType: NotificationType.profile,
          senderName: user.userName ?? '',
        ),
      );

      emit(FollowSuccess());
    } catch (e) {
      log('Follow operation failed: $e');
      emit(FollowFailure(errorMsg: e.toString()));
    }
  }

  Future<void> unfollowUser({
    required String myid,
    required String otherId,
  }) async {
    log('Unfollowing user: $otherId');
    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.update(
          FirebaseFirestore.instance.collection('users').doc(myid),
          {
            'following': FieldValue.arrayRemove([otherId])
          },
        );

        transaction.delete(
          FirebaseFirestore.instance
              .collection('users')
              .doc(otherId)
              .collection('followers')
              .doc(myid),
        );

        transaction.update(
          FirebaseFirestore.instance.collection('users').doc(myid),
          {'followingCount': FieldValue.increment(-1)},
        );

        transaction.update(
          FirebaseFirestore.instance.collection('users').doc(otherId),
          {'followersCount': FieldValue.increment(-1)},
        );
      });

      _notificationCubit.deleteNotification(
        notificationCheck: NotificationCheck(
          receiverId: otherId,
          senderId: myid,
          uniqueId: otherId,
          notificationType: NotificationType.profile,
          isThatLike: false,
          isThatPost: false,
        ),
      );

      emit(UnfollowSuccess());
    } catch (e) {
      log('Unfollow operation failed: $e');
      emit(UnfollowFailure(errorMsg: e.toString()));
    }
  }
}

class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer({required this.delay});

  void run(VoidCallback action) {
    cancel();
    _timer = Timer(delay, action);
  }

  void cancel() {
    _timer?.cancel();
  }

  bool isRunning() {
    return _timer?.isActive ?? false;
  }
}
