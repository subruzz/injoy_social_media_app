import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/common/entities/user_entity.dart';
import 'package:social_media_app/features/post_status_feed/domain/usecases/get_for_you_posts.dart';

part 'for_you_post_event.dart';
part 'for_you_post_state.dart';

class ForYouPostBloc extends Bloc<ForYouPostEvent, ForYouPostState> {
  final GetForYouPostsUseCase _forYouPostsUseCase;
  ForYouPostBloc(this._forYouPostsUseCase) : super(ForYouPostInitial()) {
    on<ForYouPostEvent>((event, emit) {
      emit(ForYouPostFeedLoading());
    });
    on<ForYouPostFeedGetEvent>(_getForYouPosts);
  }

  FutureOr<void> _getForYouPosts(
      ForYouPostFeedGetEvent event, Emitter<ForYouPostState> emit) async {
    final res = await _forYouPostsUseCase(
        GetForYouPostsUseCaseParams(user: event.user));

    res.fold((failure) => emit(ForYouPostFeedError(errorMsg: failure.message)),
        (success) => emit(ForYouPostFeedSuccess(forYouPosts: success)));
  }
}
