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

  // Future<void> getNearAndInteretsMatchingUsers(
  //     {required String myId,
  //     required double? latitude,
  //     required List<String> interests,
  //     required List<String> following,
  //     required double? longitude}) async {
  //   if (longitude == null || latitude == null) {
  //     return;
  //   }
  //   emit(ExploreUsersLoading());
  //   final res = await _getNearybyUsersUseCase(GetNearybyUsersUseCaseParams(
  //       interests: interests,
  //       following: following,
  //       myId: myId,
  //       latitude: latitude,
  //       longitude: longitude));

  //   res.fold((failure) => emit(ExploreUsersError(failure.message)),
  //       (success) => emit(ExploreUsersLoaded(suggestedUsers: success)));
  // }
}
