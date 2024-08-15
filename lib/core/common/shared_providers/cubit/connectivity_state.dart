part of 'connectivity_cubit.dart';

sealed class ConnectivityState extends Equatable {
  const ConnectivityState();

  @override
  List<Object> get props => [];
}

final class ConnectivityInitial extends ConnectivityState {}

final class ConnectivityLoading extends ConnectivityState {}

final class ConnectivityNotConnected extends ConnectivityState {}

final class ConnectivityConnected extends ConnectivityState {}

final class ConnectivityFailure extends ConnectivityState {}
