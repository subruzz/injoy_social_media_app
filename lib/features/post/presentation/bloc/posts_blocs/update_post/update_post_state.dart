part of 'update_post_bloc.dart';

sealed class UpdatePostState extends Equatable {
  const UpdatePostState();

  @override
  List<Object> get props => [];
}

final class UpdatePostInitial extends UpdatePostState {}

final class UpdatePostLoading extends UpdatePostState {}

final class UpdatePostSuccess extends UpdatePostState {

}

final class UpdatePostsError extends UpdatePostState {
  final String errorMsg;

  const UpdatePostsError({required this.errorMsg});
}
