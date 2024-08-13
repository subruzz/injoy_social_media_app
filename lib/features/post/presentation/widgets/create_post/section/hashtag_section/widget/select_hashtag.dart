import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/extensions/localization.dart';
import 'package:social_media_app/core/utils/other/debouncer.dart';
import 'package:social_media_app/core/theme/color/app_colors.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/search_hashtag/search_hashtag_bloc.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/select_tags_cubit/select_tags_cubit.dart';
import 'package:social_media_app/features/post/presentation/widgets/create_post/section/hashtag_section/widget/search_hashtag.dart';

class SelectHashtag extends StatelessWidget {
  SelectHashtag(
      {super.key,
      required this.selectTagsCubit,
      required this.hashtagcontroller});
  final SelectTagsCubit selectTagsCubit;
  final TextEditingController hashtagcontroller;
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 500));
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return SearchHashTagSheet(
                  addToUi: (value) {
                    selectTagsCubit.addTag(value);
                  },
                  hashtagController: hashtagcontroller,
                  debouncer: _debouncer,
                  onpresses: () {
                    selectTagsCubit.addTag(hashtagcontroller.text.trim());
                  });
            },
          ).then((result) {
            _debouncer.cancel();
            hashtagcontroller.clear();
            context.read<SearchHashtagBloc>().add(SearchHashTagReset());
          });
        },
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: AppDarkColor().secondaryBackground,
          ),
          child: Text('#${context.l10n!.hashtags}'),
        ),
      ),
    );
  }
}
