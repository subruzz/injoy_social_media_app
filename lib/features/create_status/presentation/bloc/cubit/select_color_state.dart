part of 'select_color_cubit.dart';

sealed class SelectColorState extends Equatable {
  const SelectColorState();

  @override
  List<Object> get props => [];
}

final class SelectColorInitial extends SelectColorState {}

final class SelectedColorState extends SelectColorState {
  final Color color;
  @override
  List<Object> get props => [color];
  const SelectedColorState({required this.color});
}
