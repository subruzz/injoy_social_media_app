import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/features/profile/domain/usecases/get_my_liked_posts.dart';

part 'get_user_liked_posts_state.dart';

class GetUserLikedPostsCubit extends Cubit<GetUserLikedPostsState> {
  final GetMyLikedPostsUseCase _getMyLikedPostsUseCase;
  GetUserLikedPostsCubit(this._getMyLikedPostsUseCase)
      : super(GetUserLikedPostsInitial());
  void getMyLikedpost(String myId) async {
    emit(GetUserLikedPostsLoading());
    final res =
        await _getMyLikedPostsUseCase(GetMyLikedPostsUseCaseParams(uid: myId));
    res.fold(
        (failure) => emit(GetUserLikedPostsError(errorMsg: failure.message)),
        (success) => emit(GetUserLikedPostsSuccess(userLikePosts: success)));
  }
}
