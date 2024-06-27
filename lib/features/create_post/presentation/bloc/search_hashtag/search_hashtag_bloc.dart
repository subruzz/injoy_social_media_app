// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_media_app/features/create_post/domain/enitities/hash_tag.dart';
import 'package:social_media_app/features/create_post/domain/usecases/searh_hashtag.dart';

part 'search_hashtag_event.dart';
part 'search_hashtag_state.dart';

class SearchHashtagBloc extends Bloc<SearchHashtagEvent, SearchHashtagState> {
  final SearchHashTagUseCase _searchHashTagUseCase;
  SearchHashtagBloc(
    this._searchHashTagUseCase,
  ) : super(SearchHashtagInitial()) {
    on<SearchHashTagReset>((event, emit) {
      emit(SearchHashtagInitial());
    });
    on<SeachHashTagGetEvent>((event, emit) async {
      emit(SearchHashtagloading());

      if (event.query.isEmpty) {
        emit(SearchHashtagInitial());
        return;
      }
      final res = await _searchHashTagUseCase(
          SearchHashTagUseCaseParms(query: event.query));
      res.fold((failure) => emit(SearchHashtagError(errorMsg: failure.message)),
          (success) {
        if (success.isEmpty) {
          emit(const SearchHashtagError(errorMsg: 'No hashtag found'));
          return;
        }
        emit(SearchHashtagSuccess(hashtags: success));
      });
    });
  }
}
