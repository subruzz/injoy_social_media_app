import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/const/app_config/app_sizedbox.dart';
import 'package:social_media_app/core/utils/other/debouncer.dart';
import 'package:social_media_app/features/post/presentation/bloc/posts_blocs/search_hashtag/search_hashtag_bloc.dart';
import 'package:social_media_app/features/post/presentation/widgets/create_post/section/hashtag_section/widget/selected_hashtags.dart';

import '../../../../../bloc/posts_blocs/select_tags_cubit/select_tags_cubit.dart';

class SearchHashTagSheet extends StatelessWidget {
  const SearchHashTagSheet(
      {super.key,
      required this.hashtagController,
      required this.debouncer,
      required this.addToUi,
      required this.onpresses,
      required this.selectTagsCubit});
  final TextEditingController hashtagController;
  final Debouncer debouncer;
  final void Function() onpresses;
  final void Function(String value) addToUi;
  final SelectTagsCubit selectTagsCubit;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
      child: Column(
        children: [
          AppSizedBox.sizedBox15H,
          TextField(
            controller: hashtagController,
            onChanged: (query) {
              debouncer.run(() {
                context
                    .read<SearchHashtagBloc>()
                    .add(SeachHashTagGetEvent(query: query));
              });
            },
            decoration: InputDecoration(
                focusedBorder: const UnderlineInputBorder(),
                hintText: 'Search Hashtags',
                filled: false,
                suffixIcon: Wrap(
                  children: [
                    IconButton(
                        onPressed: onpresses, icon: const Icon(Icons.add)),
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.check))
                  ],
                ),
                border: const UnderlineInputBorder()),
          ),
          AppSizedBox.sizedBox10H,
          SelectedHashtags(
            selectTagsCubit: selectTagsCubit,
          ),
          AppSizedBox.sizedBox10H,
          BlocConsumer<SearchHashtagBloc, SearchHashtagState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is SearchHashtagError) {
                return Center(child: Text(state.errorMsg));
              }
              if (state is SearchHashtagloading) {
                return const CircularProgressIndicator();
              }
              if (state is SearchHashtagInitial) {
                return const Center(
                  child: Text('Search for hashtags'),
                );
              } else if (state is SearchHashtagSuccess) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.hashtags.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          addToUi(state.hashtags[index].hashtagName);
                        },
                        title: Text('#${state.hashtags[index].hashtagName}'),
                      );
                    },
                  ),
                );
              } else {
                return const Center(
                  child: SizedBox(),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
