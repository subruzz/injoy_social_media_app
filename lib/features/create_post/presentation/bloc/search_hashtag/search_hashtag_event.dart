part of 'search_hashtag_bloc.dart';

sealed class SearchHashtagEvent extends Equatable {
  const SearchHashtagEvent();

  @override
  List<Object> get props => [];
}

final class SeachHashTagGetEvent extends SearchHashtagEvent {
  final String query;

  const SeachHashTagGetEvent({required this.query});
}
