import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/core/const/app_msg/app_error_msg.dart';
import 'package:social_media_app/core/services/assets/asset_model.dart';
import 'package:social_media_app/features/post/domain/usecases/post/create_posts.dart';
import 'package:uuid/uuid.dart';

import '../../../../domain/enitities/update_post.dart';
import '../../../../domain/usecases/post/delete_post.dart';
import '../../../../domain/usecases/post/update_post.dart';

part 'create_post_event.dart';
part 'create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  final CreatePostsUseCase _createPostsUseCase;
  final DeletePostsUseCase _deletePostsUseCase;
  final UpdatePostsUseCase _updatePostsUseCase;

  CreatePostBloc(this._createPostsUseCase, this._deletePostsUseCase,
      this._updatePostsUseCase)
      : super(CreatePostInitial()) {
    on<PostDeleteEvent>(_deletePost);
    on<UpdatePostEvent>(_updatePost);
    on<CreatePostClickEvent>(
      (event, emit) async {
        emit(CreatePostLoading());

        if (event.description == null && event.postPics.isEmpty) {
          emit(const CreatePostFailure(
              errorMsg: AppErrorMessages.postNoContent));
          return;
        }
        final newPost = PostEntity(
            isEdited: false,
            likesCount: 0,
            isCommentOff: event.isCommentOff,
            userFullName: event.userFullName,
            postId: const Uuid().v4(),
            creatorUid: event.creatorUid,
            createAt: Timestamp.now(),
            username: event.username,
            description: event.description,
            likes: const [],
            location: event.location,
            latitude: event.latitude,
            longitude: event.longitude,
            totalComments: 0,
            hashtags: event.hashtags,
            userProfileUrl: event.userProfileUrl,
            postImageUrl: const []);
        final res = await _createPostsUseCase(CreatePostsUseCaseParams(
            post: newPost,
            image: event.postPics,
            postImgesFromWeb: event.postImgesFromWeb,
            isReel: event.isReel));
        res.fold(
            (failure) => emit(CreatePostFailure(errorMsg: failure.details)),
            (success) => emit(CreatePostSuccess()));
      },
    );
  }

  FutureOr<void> _deletePost(
      PostDeleteEvent event, Emitter<CreatePostState> emit) async {
    emit(PostDeletionLoading());

    final res = await _deletePostsUseCase(DeletePostsUseCaseParams(
        postId: event.postId, isReel: true, postMedias: event.postMedias));

    res.fold((failure) => emit(PostDeletionFailure()),
        (success) => emit(PostDeletionSuccess()));
  }

  FutureOr<void> _updatePost(
      UpdatePostEvent event, Emitter<CreatePostState> emit) async {
    emit(UpdatePostLoading());

    final updatedPost = UpdatePostEntity(
      oldPostHashtags: event.oldPostHashTags,
      hashtags: event.hashtags,
      description: event.description,
    );
    final res = await _updatePostsUseCase(UpdatePostsUseCaseParams(
        post: updatedPost, postUser: event.user, postId: event.postId));
    res.fold((failure) => emit(UpdatePostsError()),
        (success) => emit(UpdatePostSuccess(updatedPost: success)));
  }
}
