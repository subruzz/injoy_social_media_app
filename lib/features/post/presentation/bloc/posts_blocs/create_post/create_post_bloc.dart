import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/const/app_msg/app_error_msg.dart';
import 'package:social_media_app/features/chat/presentation/widgets/person_chat_page/utils.dart';
import 'package:social_media_app/features/post/domain/usecases/post/create_posts.dart';
import 'package:uuid/uuid.dart';

part 'create_post_event.dart';
part 'create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  final CreatePostsUseCase _createPostsUseCase;
  CreatePostBloc(this._createPostsUseCase) : super(CreatePostInitial()) {
    on<CreatePostEvent>((event, emit) {
      emit(CreatePostLoading());
    });
    on<CreatePostClickEvent>((event, emit) async {
      if (event.description == null && event.postPics.isEmpty) {
        emit(const CreatePostFailure(errorMsg: AppErrorMessages.postNoContent));
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
      final res = await _createPostsUseCase(
          CreatePostsUseCaseParams(post: newPost, image: event.postPics));
      res.fold((failure) => emit(CreatePostFailure(errorMsg: failure.details)),
          (success) => emit(CreatePostSuccess()));
    });
  }
}
