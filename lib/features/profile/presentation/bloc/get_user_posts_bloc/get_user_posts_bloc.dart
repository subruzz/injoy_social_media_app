// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/features/profile/domain/usecases/get_user_posts.dart';

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
  }

  FutureOr<void> _getUserPostsrequestedEvent(
      GetUserPostsrequestedEvent event, Emitter<GetUserPostsState> emit) async {
    final result =
        await _getUserPostsUseCase(GetUserPostsUseCaseParams(uid: event.uid));
    result.fold(
        ((failure) => emit(GetUserPostsError(errorMsg: failure.message))),
        (success) => emit(GetUserPostsSuccess(
            userPosts: success.userPosts,
            userAllPostImages: success.userPostImages)));
  }
}
