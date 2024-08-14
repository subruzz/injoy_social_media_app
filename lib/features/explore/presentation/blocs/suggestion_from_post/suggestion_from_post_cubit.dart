import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/post.dart';

import '../../../domain/usecases/get_suggested_posts_from_post.dart';

part 'suggestion_from_post_state.dart';

class SuggestionFromPostCubit extends Cubit<SuggestionFromPostState> {
  final GetSuggestedPostsFromPostUseCase _getSuggestedPostsFromPostUseCase;
  final PostEntity post;
  SuggestionFromPostCubit(this._getSuggestedPostsFromPostUseCase, this.post)
      : super( SuggestionFromPostState(posts: [post]));

  Future<void> getSuggestionFromPost({
    required String myId,
    required PostEntity post,
  }) async {
    // Emit the loading state
    emit(state.copyWith(isLoading: true));

    // Call the use case to get suggested posts
    final res = await _getSuggestedPostsFromPostUseCase(
      GetSuggestedPostsFromPostUseCaseParams(myId: myId, post: post),
    );

    // Handle the result
    res.fold(
      (failure) {
        // Emit the error state
        emit(state.copyWith(hasError: true, isLoading: false));
      },
      (success) {
        // Update the posts and emit the success state
        final updatedPosts = List<PostEntity>.from(state.posts)
          ..addAll(success);
        emit(state.copyWith(posts: updatedPosts, isLoading: false));
      },
    );
  }
}
