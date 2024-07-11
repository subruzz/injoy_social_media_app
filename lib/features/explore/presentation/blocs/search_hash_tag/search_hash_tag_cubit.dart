import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/features/explore/domain/usecases/search_hash_tags.dart';
import 'package:social_media_app/features/post/domain/enitities/hash_tag.dart';

part 'search_hash_tag_state.dart';

class SearchHashTagCubit extends Cubit<SearchHashTagState> {
  final SearchHashTagsUseCase _searchHashTagUseCase;
  SearchHashTagCubit(this._searchHashTagUseCase)
      : super(SearchHashTagInitial());
  Future<void> searchHashTags(String query) async {
    emit(SearchHashTagLoading());
    final res =
        await _searchHashTagUseCase(SearchHashTagsUseCaseParams(query: query));
    res.fold((failure) => emit(SearchHashTagFailure(erroMsg: failure.message)),
        (success) {
      emit(SearchHashTagSuccess(searchedHashtags: success));
    });
  }
}
