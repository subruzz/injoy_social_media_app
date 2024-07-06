part of 'select_interest_cubit.dart';

sealed class SelectInterestState extends Equatable {
  const SelectInterestState();

  @override
  List<Object> get props => [];
}

final class SelectInterestInitial extends SelectInterestState {}

final class SelectInterestFailure extends SelectInterestState {}

final class SelectInterestLoading extends SelectInterestState {}

final class SelectInterestEmpty extends SelectInterestState {}

final class SelectedInterestsSuccess extends SelectInterestState {

}
