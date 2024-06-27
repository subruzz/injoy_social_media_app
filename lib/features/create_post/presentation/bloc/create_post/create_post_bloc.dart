import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/features/create_post/domain/usecases/create_posts.dart';
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
      print(event.latitude);
      final newPost = PostEntity(
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
