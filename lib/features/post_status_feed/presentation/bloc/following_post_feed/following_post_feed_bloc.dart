import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/features/post_status_feed/domain/usecases/get_following_posts.dart';

part 'following_post_feed_event.dart';
part 'following_post_feed_state.dart';

class FollowingPostFeedBloc
    extends Bloc<FollowingPostFeedEvent, FollowingPostFeedState> {
  final GetFollowingPostsUseCase _followingPostsUseCase;
  FollowingPostFeedBloc(this._followingPostsUseCase)
      : super(FollowingPostFeedInitial()) {
    on<FollowingPostFeedEvent>((event, emit) {
      emit(FollowingPostFeedLoading());
    });
    on<FollowingPostFeedGetEvent>(_postFeedGetEvent);
  }

  FutureOr<void> _postFeedGetEvent(FollowingPostFeedGetEvent event,
      Emitter<FollowingPostFeedState> emit) async {
    final res = await _followingPostsUseCase(
        GetFollowingPostsUseCaseParams(uId: event.uId));
    res.fold(
        (failure) => emit(FollowingPostFeedError(errorMsg: failure.message)),
        (success) => emit(FollowingPostFeedSuccess(followingPosts: success)));
  }
}
