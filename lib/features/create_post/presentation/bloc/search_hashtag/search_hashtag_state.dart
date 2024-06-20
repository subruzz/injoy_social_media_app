part of 'search_hashtag_bloc.dart';

sealed class SearchHashtagState extends Equatable {
  const SearchHashtagState();

  @override
  List<Object> get props => [];
}

final class SearchHashtagInitial extends SearchHashtagState {}

final class SearchHashtagloading extends SearchHashtagState {}

final class SearchHashtagError extends SearchHashtagState {
  final String errorMsg;

  const SearchHashtagError({required this.errorMsg});
}

final class SearchHashtagSuccess extends SearchHashtagState {
  final List<HashTag> hashtags;

  const SearchHashtagSuccess({required this.hashtags});
}

