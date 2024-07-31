import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/features/post_status_feed/domain/usecases/get_following_posts.dart';

part 'following_post_feed_event.dart';
part 'following_post_feed_state.dart';

class FollowingPostFeedBloc
    extends Bloc<FollowingPostFeedEvent, FollowingPostFeedState> {
  DocumentSnapshot? lastDoc;
  bool hasMore = true;

  final GetFollowingPostsUseCase _followingPostsUseCase;
  FollowingPostFeedBloc(this._followingPostsUseCase)
      : super(FollowingPostFeedInitial()) {
    on<FollowingPostFeedEvent>((event, emit) {
      // emit(FollowingPostFeedLoading());
    });
    on<FollowingPostFeedGetEvent>(_postFeedGetEvent);
  }

  FutureOr<void> _postFeedGetEvent(FollowingPostFeedGetEvent event,
      Emitter<FollowingPostFeedState> emit) async {
    emit(FollowingPostFeedLoading());
    final res = await _followingPostsUseCase(GetFollowingPostsUseCaseParams(
        uId: event.uId,
        following: event.following,
        lastDoc: event.lastDoc,
        limit: 3));
    res.fold(
        (failure) => emit(FollowingPostFeedError(errorMsg: failure.message)),
        (success) {
      final currentState = state;
      log('current state is $currentState');
      if (currentState is FollowingPostFeedSuccess && event.isLoadMore) {
        log('in the bloc currently we have ${currentState.followingPosts.length} and new is ${success.posts.length}');
        final allPosts = currentState.followingPosts + success.posts;
        log('all posts is ${allPosts.length}');

        emit(FollowingPostFeedSuccess(
            followingPosts: allPosts,
            hasMore: success.hasMore,
            lastDoc: success.lastDoc));

      } else {
        log('else case');
        emit(FollowingPostFeedSuccess(
            followingPosts: success.posts,
            hasMore: success.hasMore,
            lastDoc: success.lastDoc));
      }
    });
  }
}
