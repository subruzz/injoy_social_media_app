import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/common/entities/post.dart';
import 'package:social_media_app/core/common/models/partial_user_model.dart';
import 'package:social_media_app/features/profile/domain/usecases/get_user_posts.dart';

part 'get_other_user_posts_state.dart';

class GetOtherUserPostsCubit extends Cubit<GetOtherUserPostsState> {
  final GetUserPostsUseCase _getUserPostsUseCase;

  GetOtherUserPostsCubit(this._getUserPostsUseCase)
      : super(GetOtherUserPostsInitial());

  void getOtherUserPosts(PartialUser user) async {
    emit(GetOtherUserPostsLoading());
    final res = await _getUserPostsUseCase(GetUserPostsUseCaseParams(user: user));
    res.fold(
        (failure) => emit(GetOtherUserPostsError(errorMsg: failure.message)),
        (success) => emit(GetOtherUserPostsSuccess(
            userPosts: success,
        )));
  }
}
