part of 'delete_post_bloc.dart';

sealed class DeletePostState extends Equatable {
  const DeletePostState();

  @override
  List<Object> get props => [];
}

final class DeletePostInitial extends DeletePostState {}

final class DeletePostFailure extends DeletePostState {
  final String errorMsg;

  const DeletePostFailure({required this.errorMsg});
}

final class DeletePostSuccess extends DeletePostState {}

final class DeletePostLoading extends DeletePostState {}
