import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/core/utils/id_generator.dart';
import 'package:social_media_app/features/notification/domain/entities/customnotifcation.dart';
import 'package:social_media_app/features/notification/presentation/pages/cubit/notification_cubit/notification_cubit.dart';
import 'package:social_media_app/features/post/domain/enitities/comment_entity.dart';
import 'package:social_media_app/features/post/domain/usecases/comment/create_comment_usecase.dart';
import 'package:social_media_app/features/post/domain/usecases/comment/delete_comment.dart';
import 'package:social_media_app/features/post/domain/usecases/comment/update_comment.dart';

part 'comment_basic_state.dart';

class CommentBasicCubit extends Cubit<CommentBasicState> {
  final CreateCommentUsecase _createCommentUsecase;
  final UpdateCommentUseCase _updateCommentUseCase;
  final DeleteCommentUseCase _deleteCommentUseCase;
  final NotificationCubit _notificationCubit;
  CommentBasicCubit({
    required CreateCommentUsecase createCommentUsecase,
    required NotificationCubit notificationCubit,
    required UpdateCommentUseCase updateCommentUseCase,
    required DeleteCommentUseCase deleteCommentUseCase,
  })  : _createCommentUsecase = createCommentUsecase,
        _updateCommentUseCase = updateCommentUseCase,
        _deleteCommentUseCase = deleteCommentUseCase,
        _notificationCubit = notificationCubit,
        super(CommentBasicInitial());

  void addComment(
      {required String comment,
      required String userName,
      String? userProfile,
      required AppUser user,
      required String postId,
      required String creatorId}) async {
    emit(CommentLoading());
    final commentId=IdGenerator.generateUniqueId();
    final newComment = CommentEntity(
        comment: comment,
        creatorId: user.id,
        userName: userName,
        isEdited: false,
        postId: postId,
        commentId: commentId,
        totalReplies: 0,
        userProfile: userProfile,
        createdAt: Timestamp.now(),
        likes: const []);
    final res = await _createCommentUsecase(
        CreateCommentUsecaseParams(comment: newComment));
    res.fold((failure) => emit(CommentError(error: failure.message)),
        (success) {
      emit(CommentAddedSuccess());
      _notificationCubit.createNotification(
        notification: CustomNotification(
          notificationId: IdGenerator.generateUniqueId(),
          text: "Commented on your post",
          time: Timestamp.now(),
          senderId: user.id,
          uniqueId: commentId,
          receiverId: creatorId,
          isThatLike: false,
          postId: postId,
          isThatPost: true,
          personalUserName: user.userName ?? '',
          personalProfileImageUrl: user.profilePic,
          notificationType: NotificationType.post,
          senderName: user.userName ?? '',
        ),
      );
    });
  }

  void deleteComment(
      {required String postId,
      required String commentId,
      required String myId,
      required String otherId}) async {
    emit(CommentLoading());

    final res = await _deleteCommentUseCase(
        DeleteCommentUseCaseParams(postId: postId, commentId: commentId));
    res.fold((failure) => emit(CommentError(error: failure.message)),
        (success) {
      emit(CommentDeletedSuccess());

      _notificationCubit.deleteNotification(
        notificationCheck: NotificationCheck(
          receiverId: otherId,
          senderId: myId,
          uniqueId: commentId,
          notificationType: NotificationType.post,
          isThatLike: false,
          postId: postId,
          isThatPost: true,
        ),
      );
    });
  }

  void updateComment(
      {required String postId,
      required String commentId,
      required String comment}) async {
    emit(CommentLoading());

    final res = await _updateCommentUseCase(UpdateCommentUseCaseParams(
        postId: postId, commentId: commentId, comment: comment));
    res.fold((failure) => emit(CommentError(error: failure.message)),
        (success) => emit(CommentSuccess()));
  }
}
