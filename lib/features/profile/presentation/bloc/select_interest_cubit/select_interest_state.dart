part of 'select_interest_cubit.dart';

sealed class SelectInterestState extends Equatable {
  const SelectInterestState();

  @override
  List<Object> get props => [];
}

final class SelectInterestInitial extends SelectInterestState {}

final class SelectedInterestsSuccess extends SelectInterestState {
  final List<String> selectedinterst;

  const SelectedInterestsSuccess({required this.selectedinterst});
  @override
  List<Object> get props => [selectedinterst];
}
