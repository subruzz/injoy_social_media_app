part of 'search_hash_tag_cubit.dart';

sealed class SearchHashTagState extends Equatable {
  const SearchHashTagState();

  @override
  List<Object> get props => [];
}

final class SearchHashTagInitial extends SearchHashTagState {}

final class SearchHashTagLoading extends SearchHashTagState {}

final class SearchHashTagFailure extends SearchHashTagState {
  final String erroMsg;

  const SearchHashTagFailure({required this.erroMsg});
}

final class SearchHashTagSuccess extends SearchHashTagState {
  final List<HashTag> searchedHashtags;
  final String query;

  const SearchHashTagSuccess(
      {required this.searchedHashtags, required this.query});
}
