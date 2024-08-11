part of 'reels_cubit.dart';

sealed class ReelsState extends Equatable {
  const ReelsState();

  @override
  List<Object> get props => [];
}

final class ReelsInitial extends ReelsState {}

final class ReelsLoading extends ReelsState {}

final class ReelsFailure extends ReelsState {}

final class ReelsSuccess extends ReelsState {
  final List<PostEntity> reels;
  final DocumentSnapshot? lastDocument;

 const ReelsSuccess({required this.reels,this.lastDocument});
}
