// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/features/profile/domain/usecases/get_user_posts.dart';

import '../../../../../../core/common/models/partial_user_model.dart';

part 'get_user_posts_event.dart';
part 'get_user_posts_state.dart';

class GetUserPostsBloc extends Bloc<GetUserPostsEvent, GetUserPostsState> {
  final GetUserPostsUseCase _getUserPostsUseCase;
  GetUserPostsBloc(
    this._getUserPostsUseCase,
  ) : super(GetUserPostsInitial()) {
    on<GetUserPostsEvent>((event, emit) {
      emit(GetUserPostsLoading());
    });
    on<GetUserPostsrequestedEvent>(_getUserPostsrequestedEvent);
    on<GetUserPostsAterPostUpdate>(_getUserPostsAterPostUpdate);
  }

  FutureOr<void> _getUserPostsrequestedEvent(
      GetUserPostsrequestedEvent event, Emitter<GetUserPostsState> emit) async {
    log('Requested for user posts');
    final result =
        await _getUserPostsUseCase(GetUserPostsUseCaseParams(user: event.user));
    log('user pots are $result');
    result.fold(
        ((failure) => emit(GetUserPostsError(errorMsg: failure.message))),
        (success) => emit(GetUserPostsSuccess(
            userPosts: success,
          )));
  }

  FutureOr<void> _getUserPostsAterPostUpdate(
      GetUserPostsAterPostUpdate event, Emitter<GetUserPostsState> emit) async {
    event.allUsePosts[event.index] = event.updatedPost;
    emit(GetUserPostsSuccess(
        userPosts: event.allUsePosts,
));
  }
}
