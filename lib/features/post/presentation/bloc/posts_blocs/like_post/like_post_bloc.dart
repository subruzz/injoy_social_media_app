// ignore: depend_on_referenced_packages
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/common/functions/firebase_helper.dart';
import 'package:social_media_app/core/utils/other/debouncer.dart';
import 'package:social_media_app/core/utils/other/id_generator.dart';
import 'package:social_media_app/features/notification/domain/entities/customnotifcation.dart';
import 'package:social_media_app/features/post/domain/usecases/post/like_post.dart';
import 'package:social_media_app/features/post/domain/usecases/post/unlike_post.dart';

import '../../../../../../core/utils/di/di.dart';
import '../../../../../settings/domain/entity/ui_entity/enums.dart';

part 'like_post_event.dart';
part 'like_post_state.dart';

class LikePostBloc extends Bloc<LikePostEvent, LikePostState> {
  final LikePostsUseCase _likePostsUseCase;
  final UnlikePostsUseCase _unlikePostsUseCase;
  final Debouncer _debouncer =
      Debouncer(delay: const Duration(milliseconds: 300));
  LikePostBloc(
    this._likePostsUseCase,
    this._unlikePostsUseCase,
  ) : super(LikePostInitial()) {
    on<LikePostEvent>((event, emit) {
      emit(LikePostLoading());
    });
    on<LikePostClickEvent>(_likePost);
    on<UnlikePostClickEvent>(_unlikePost);
  }

  FutureOr<void> _likePost(
      LikePostClickEvent event, Emitter<LikePostState> emit) async {
    final res = await _likePostsUseCase(LikePostsUseCaseParams(
        isReel: event.isReel,
        postId: event.postId,
        currentUserId: event.user.id));
    res.fold((failure) => emit(LikePostLoading()), (success) {
      emit(LikePostSuccess());
      if (event.otherUserId == event.user.id) return;
      if (_debouncer.isRunning()) _debouncer.cancel();
      _debouncer.run(() {
        serviceLocator<FirebaseHelper>().createNotification(
          post: (
            postId: event.postId,
            commentId: null,
            isThatVdo: event.post.isThatvdo
          ),
          chatNotification: null,
          partialUser: null,
          notificationPreferenceType: NotificationPreferenceEnum.likes,
          notification: CustomNotification(
            notificationId: IdGenerator.generateUniqueId(),
            text: "Liked your post",
            time: Timestamp.now(),
            senderId: event.user.id,
            uniqueId: event.postId,
            receiverId: event.otherUserId,
            isThatLike: true,
            isThatPost: true,
            personalUserName: event.user.userName ?? '',
            personalProfileImageUrl: event.user.profilePic,
            notificationType: NotificationType.post,
            senderName: event.user.userName ?? '',
          ),
        );
      });
    });
  }

  FutureOr<void> _unlikePost(
      UnlikePostClickEvent event, Emitter<LikePostState> emit) async {
    final res = await _unlikePostsUseCase(UnlikePostsUseCaseParams(
        isReel: event.isReel, postId: event.postId, currentUserId: event.myId));
    res.fold((failure) => emit(LikePostLoading()), (success) {
      emit(LikePostSuccess());
      if (_debouncer.isRunning()) _debouncer.cancel();

      serviceLocator<FirebaseHelper>().deleteNotification(
        notificationCheck: NotificationCheck(
          receiverId: event.ohterUseId,
          senderId: event.myId,
          uniqueId: event.postId,
          notificationType: NotificationType.profile,
          isThatLike: true,
          isThatPost: true,
        ),
      );
    });
  }
}
