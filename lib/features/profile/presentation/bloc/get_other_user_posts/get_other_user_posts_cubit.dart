import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/features/profile/domain/usecases/get_user_posts.dart';

part 'get_other_user_posts_state.dart';

class GetOtherUserPostsCubit extends Cubit<GetOtherUserPostsState> {
  final GetUserPostsUseCase _getUserPostsUseCase;

  GetOtherUserPostsCubit(this._getUserPostsUseCase)
      : super(GetOtherUserPostsInitial());

  void getOtherUserPosts(String uId) async {
    emit(GetOtherUserPostsLoading());
    final res = await _getUserPostsUseCase(GetUserPostsUseCaseParams(uid: uId));
    res.fold(
        (failure) => emit(GetOtherUserPostsError(errorMsg: failure.message)),
        (success) => emit(GetOtherUserPostsSuccess(
            userPosts: success.userPosts,
            userAllPostImages: success.userPostImages)));
  }
}
