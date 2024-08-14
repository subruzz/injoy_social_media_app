import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/post.dart';

import '../../../domain/usecases/get_all_posts.dart';

part 'explore_user_state.dart';

class ExploreAllPostsCubit extends Cubit<ExploreAllPostsState> {
  // final GetSuggestedUsersUseCase _getSuggestedUsersUseCase;
  final GetAllPostsUseCase _getAllPostsUseCase;
  ExploreAllPostsCubit(this._getAllPostsUseCase) : super(ExploreUserInitial());
  Future<void> getAllposts({
    required String myId,
  }) async {
    emit(ExplorePostsLoading());

    final res = await _getAllPostsUseCase(GetAllPostsUseCaseParams(id: myId));

    res.fold((failure) => emit(ExplorePostsError(failure.message)),
        (success) => emit(ExploreAllPostsLoaded(allPosts: success)));
  }

}
