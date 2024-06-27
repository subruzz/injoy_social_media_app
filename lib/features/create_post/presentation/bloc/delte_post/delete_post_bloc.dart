import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/create_post/domain/usecases/delete_post.dart';

part 'delete_post_event.dart';
part 'delete_post_state.dart';

class DeletePostBloc extends Bloc<DeletePostEvent, DeletePostState> {
  final DeletePostsUseCase _deletePostsUseCase;
  DeletePostBloc(this._deletePostsUseCase) : super(DeletePostInitial()) {
    on<DeletePostEvent>((event, emit) {
      emit(DeletePostLoading());
    });
    on<DeletePost>(_deletePost);
  }

  FutureOr<void> _deletePost(
      DeletePost event, Emitter<DeletePostState> emit) async {
    final res = await _deletePostsUseCase(
        DeletePostsUseCaseParams(postId: event.postId));
    res.fold((failure) => emit(DeletePostFailure(errorMsg: failure.message)),
        (suceess) => emit(DeletePostSuccess()));
  }
}
