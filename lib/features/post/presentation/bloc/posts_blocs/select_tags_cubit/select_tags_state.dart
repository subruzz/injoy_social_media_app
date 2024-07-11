part of 'select_tags_cubit.dart';

sealed class SelectTagsState extends Equatable {
  const SelectTagsState();

  @override
  List<Object> get props => [];
}

final class SelectTagsInitial extends SelectTagsState {}
final class SelectTagsLoading extends SelectTagsState {}

final class SelectdTagsSuccess extends SelectTagsState {
  final List<String> tags;

  const SelectdTagsSuccess({required this.tags});
}
