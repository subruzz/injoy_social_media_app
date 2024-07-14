part of 'search_user_cubit.dart';

sealed class SearchUserState extends Equatable {
  const SearchUserState();

  @override
  List<Object> get props => [];
}

final class SearchUserInitial extends SearchUserState {}

final class SearchUserLoading extends SearchUserState {}

final class SearchUserFailure extends SearchUserState {
  final String erroMsg;

  const SearchUserFailure({required this.erroMsg});
}

final class SearchUserSuccess extends SearchUserState {
  final List<PartialUser> searchedUsers;
  final String query;

  const SearchUserSuccess({required this.searchedUsers, required this.query});
}
