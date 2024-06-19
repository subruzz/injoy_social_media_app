import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'select_tags_state.dart';

class SelectTagsCubit extends Cubit<SelectTagsState> {
  final Set<String> hashTags = {};
  SelectTagsCubit() : super(SelectTagsInitial());
  void addTag(String tag) {
    if (tag.isEmpty) return;
    emit(SelectTagsLoading());
    print(hashTags.length);
    if (hashTags.length <= 5) {
      hashTags.add(tag);
      emit(
        SelectdTagsSuccess(
          tags: List.from(hashTags),
        ),
      );
    } else {
      emit(SelectdTagsSuccess(
        tags: List.from(hashTags),
      ));
    }
  }

  void removeTag(String tag) {
    emit(SelectTagsLoading());

    hashTags.remove(tag);
    if (tag.isEmpty) {
      return;
    }
    emit(SelectdTagsSuccess(
      tags: List.from(hashTags),
    ));
  }
}
