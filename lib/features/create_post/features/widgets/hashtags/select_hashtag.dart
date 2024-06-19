import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:social_media_app/core/const/debouncer.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/features/create_post/features/bloc/search_hashtag/search_hashtag_bloc.dart';
import 'package:social_media_app/features/create_post/features/bloc/select_tags_cubit/select_tags_cubit.dart';
import 'package:social_media_app/features/create_post/features/widgets/hashtags/search_hashtag.dart';

class SelectHashtag extends StatelessWidget {
  const SelectHashtag({super.key, required this.selectTagsCubit, required this.debouncer, required this.hashtagcontroller});
  final SelectTagsCubit selectTagsCubit;
  final Debouncer debouncer;
  final TextEditingController hashtagcontroller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: false,
            context: context,
            builder: (context) {
              return SearchHashTagSheet(
                  searchHashtagBloc: GetIt.instance<SearchHashtagBloc>(),
                  addToUi: (value) {
                    selectTagsCubit.addTag(value);
                  },
                  hashtagController: hashtagcontroller,
                  debouncer: debouncer,
                  onpresses: () {
                    selectTagsCubit.addTag(hashtagcontroller.text.trim());
                  });
            },
          );
        },
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: AppDarkColor().secondaryBackground,
          ),
          child: const Text('#hashtags'),
        ),
      ),
    );
  }
}
